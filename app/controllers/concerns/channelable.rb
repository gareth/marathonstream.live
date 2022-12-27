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

  def twitch_channel
    return unless request.subdomain.present?

    target_channel = request.subdomain

    Twitch::Channel.find_by!(twitch_username: target_channel)
  rescue ActiveRecord::RecordNotFound
    raise NoChannelError, "Channel not found: `#{target_channel}`"
  end
end
