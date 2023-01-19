class ChannelsController < ApplicationController
  include Channelable

  def show
    @stream = twitch_channel.streams.active.first

    return unless @stream

    render "streams/show"
  end
end
