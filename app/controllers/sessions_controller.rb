class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def show
    return new unless current_session.authenticated?

    render json: current_session
  end

  def new
    respond_to do |format|
      format.json { head :not_found }
      format.html { render :new, status: :not_found }
    end
  end

  def create
    user_info = request.env["omniauth.auth"]

    provider = user_info["provider"]
    session["identity.provider"] = provider

    case provider
    when "twitch"
      user = Twitch::User.find_or_initialize_by(uid: user_info["uid"])
      user.login = user_info.dig("info", "nickname")
      user.display_name = user_info.dig("info", "name")

      if (scopes = user_info.dig("credentials", "scope"))
        user.token_scopes = Array(scopes)
      end
      user.token = user_info.dig("credentials", "token")
      user.refresh_token = user_info.dig("credentials", "refresh_token")
      user.token_expires_at = (Time.at(user_info.dig("credentials", "expires_at")) if user_info.dig("credentials",
                                                                                                    "expires"))
      user.save

      session["identity.data"] = {
        uid: user_info.fetch("uid"),
        login: user_info.dig("info", "nickname"),
        name: user_info.dig("info", "name"),
        credentials: user_info.fetch("credentials")
      }
    when "developer"
      session["identity.data"] = {
        role: user_info.dig("info", "role")
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
