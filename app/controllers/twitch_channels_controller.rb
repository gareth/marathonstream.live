class TwitchChannelsController < ApplicationController
  after_action :verify_authorized
  # after_action :verify_policy_scoped, only: :index

  include Channelable

  layout "channel"

  rescue_from Channelable::NoChannelError do |_exception|
    @channel = TwitchChannel.new(username: twitch_channel_param)

    if policy(@channel).create?
      render :new, layout: "application"
    else
      cli = Integrations::Twitch.client.app_client

      @user = cli.users.retrieve(username: twitch_channel_param)

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
      redirect_to path_root_url and return
    end

    user = TwitchUser.find_by(login: twitch_channel_param)

    channel = TwitchChannel.new(username: twitch_channel_param,
                                display_name: user&.display_name || twitch_channel_param)

    authorize(channel)

    channel.save
    redirect_to path_root_url
  end

  def edit
    authorize(twitch_channel)
  end

  def update
    authorize(twitch_channel).update(channel_params)

    redirect_to path_root_url
  end

  def destroy
    authorize(twitch_channel).destroy

    redirect_to path_root_url
  end

  private

  def channel_params
    params.require(:channel).permit(:sync_moderators)
  end
end
