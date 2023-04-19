class PagesController < ApplicationController
  def home
    @twitch_channel = Twitch::Channel.find_by username: current_user.login if current_user
  end
end
