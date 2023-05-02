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

    user = Twitch::User.find_by(login: subdomain)

    channel = Twitch::Channel.new(username: subdomain, display_name: user&.display_name || subdomain)

    authorize(channel)

    channel.save
    redirect_to root_url
  end

  def edit
    authorize(twitch_channel)
  end

  def update
    authorize(twitch_channel).update(channel_params)

    redirect_to channel_url
  end

  def destroy
    authorize(twitch_channel).destroy

    redirect_to root_url
  end

  private

  def channel_params
    params.require(:channel).permit(:sync_moderators)
  end
end
