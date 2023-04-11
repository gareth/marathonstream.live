class ChannelsController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  include Channelable

  layout "channel"

  rescue_from Channelable::NoChannelError do |_exception|
    channel = Twitch::Channel.new(username: subdomain)

    if policy(channel).create?
      render :new, layout: "application"
    else
      render :missing, status: 404, layout: "application"
    end
  end

  def show
    @stream = authorize(twitch_channel).streams.active.first

    return unless @stream

    render "streams/show"
  end
end
