class ChannelsController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  include Channelable

  layout "channel"

  rescue_from Channelable::NoChannelError do |_exception|
    @channel = Twitch::Channel.new(username: subdomain)

    if policy(@channel).create?
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

  def create
    if twitch_channel?
      authorize(twitch_channel)
      redirect_to root_url and return
    end

    channel = Twitch::Channel.new(username: subdomain, display_name: subdomain)

    authorize(channel)

    channel.save
    redirect_to root_url
  end

  def destroy
    authorize(twitch_channel).destroy

    redirect_to root_url
  end
end
