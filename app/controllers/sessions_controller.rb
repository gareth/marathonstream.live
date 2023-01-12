class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def show
    return new unless current_user.authenticated?

    render json: current_user
  end

  def new
    render :new
  end

  def create
    user_info = request.env["omniauth.auth"]

    provider = user_info["provider"]
    session["identity.provider"] = provider

    case provider
    when "twitch"
      session["identity.data"] = {
        uid: user_info.fetch("uid"),
        login: user_info.dig("info", "nickname"),
        name: user_info.dig("info", "name"),
        credentials: user_info.fetch("credentials")
      }
    else
      raise format("Unknown provider: %p", provider)
    end

    redirect_to root_url
  end

  def destroy
    # Just to be explicit about what we want to remove
    session.delete("identity.provider")
    session.delete("identity.data")

    # But clear everything else anyway
    reset_session

    redirect_to root_url
  end
end
