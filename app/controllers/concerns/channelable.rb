# A Controller concern that identifies the controller as only being available in
# relation to a specific Twitch channel. Currently this is implemented by
# looking up the Twitch channel based on the subdomain being used to access the
# site.
#
# Additionally we incorporate logic for simulating a subdomain in environments
# where this isn't possible.
#
# Depends on being included somewhere with a `request` method that returns an
# ActionDispatch::Request object (with an `#env` method)
module Channelable
  class NoChannelError < StandardError
  end

  extend ActiveSupport::Concern

  def self.subdomain(request)
    request.subdomain.presence || request.env[DevelopmentSubdomain::ENV_KEY]
  end

  included do
    layout "channelable"

    helper_method :twitch_channel
  end

  def twitch_channel_param
    params[:channel_name] || subdomain
  end

  def twitch_channel
    return @channel if @channel

    return unless twitch_channel_param.present?

    target_channel = twitch_channel_param

    TwitchChannel.find_by!(username: target_channel)
  rescue ActiveRecord::RecordNotFound
    raise NoChannelError, "Channel not found: `#{target_channel}`"
  end

  def twitch_channel?
    twitch_channel
  rescue NoChannelError
    nil
  end

  def subdomain
    Channelable.subdomain(request)
  end

  def current_session
    @current_session ||=
      case session["identity.provider"]
      when "twitch"
        data = session["identity.data"]
        identity = TwitchUser.find_by(uid: data["uid"])

        role =
          if twitch_channel?&.twitch_id == data["uid"]
            # If there's a Twitch channel and you're signed in as a user with that channel's ID
            Role.broadcaster
          elsif twitch_channel_param == data["login"] # rubocop:disable Lint/DuplicateBranch
            # If you're signed in as a user matching the current subdomain
            Role.broadcaster
          else
            Role.viewer
          end

        UserSession.new(role:, identity:)
      else
        super
      end
  end

  def default_url_options
    super.merge(channel_name: twitch_channel_param).compact
  end
end
