# A Controller concern that identifies the controller as only being available in
# relatino to a specific Twitch channel. Currently this is implemented by
# looking up the Twitch channel based on the subdomain being used to access the
# site.
#
# Additionally we incporporate logic for simulating a subdomain in environments
# where this isn't possible.
#
# Depends on being included somewhere with a `request` method that returns an
# ActionDispatch::Request object (with an `#env` method)
module Channelable
  NoChannelError = Class.new(StandardError)

  extend ActiveSupport::Concern

  def self.subdomain(request)
    request.subdomain.presence || request.env[DevelopmentSubdomain::ENV_KEY]
  end

  included do
    layout "channelable"

    helper_method :twitch_channel
  end

  def twitch_channel
    return unless subdomain.present?

    target_channel = subdomain

    Twitch::Channel.find_by!(username: target_channel)
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
        identity = Twitch::User.find_by(uid: data["uid"])

        role =
          if twitch_channel?&.twitch_id == data["uid"]
            # If there's a Twitch channel and you're signed in as a user with that channel's ID
            Role.broadcaster
          elsif subdomain == data["login"] # rubocop:disable Lint/DuplicateBranch
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
end
