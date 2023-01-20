class ChannelsController < ApplicationController
  include Channelable

  layout "channel"

  rescue_from Channelable::NoChannelError do |exception|
    # TODO: Remove this handler when account creation is sorted
    if request.local?
      Twitch::Channel.create(twitch_id: rand(1_000_000), username: subdomain, display_name: subdomain)

      redirect_to root_url
    else
      rescue_action_without_handler(exception)
    end
  end

  def show
    @stream = twitch_channel.streams.active.first

    return unless @stream

    render "streams/show"
  end
end
