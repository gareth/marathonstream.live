class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_session, :current_user, :subdomain_param, :subdomain_p

  rescue_from(Pundit::NotAuthorizedError) do |e|
    error_klass = e.class.name.demodulize
    error_type = error_klass
    error = format("%<error>s (%<type>s)", error: e, type: error_type)

    render plain: "Forbidden: #{error}", status: :forbidden
  end

  private

  def subdomain_param
    Rails.application.config.x.marathon.subdomain_param
  end
  alias subdomain_p subdomain_param

  def current_user
    current_session.identity
  end

  def current_session
    case session["identity.provider"]
    when "developer"
      role = session.dig("identity.data", "role").to_sym
      UserSession.new(role:)
    when "twitch"
      identity = Twitch::User.find_by(uid: session.dig("identity.data", "uid"))
      UserSession.new(role: Role.viewer, identity:)
    else
      # TODO: Remove the test hook maybe
      role = session.fetch("test.role", Role.anonymous).to_sym
      UserSession.new(role:)
    end
  end

  def pundit_user
    current_session
  end
end
