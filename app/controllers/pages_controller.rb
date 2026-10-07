class PagesController < ApplicationController
  def home
    @twitch_channel = TwitchChannel.find_by username: current_user.login if current_user
  end
end
