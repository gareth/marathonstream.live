class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user

  rescue_from(Pundit::NotAuthorizedError) do |e|
    error_klass = e.class.name.demodulize
    error_type = error_klass
    error = format("%<error>s (%<type>s)", error: e, type: error_type)

    render plain: "Forbidden: #{error}", status: :forbidden
  end

  def current_user
    case session["identity.provider"]
    when "developer"
      role = session.dig("identity.data", "role").to_sym
      UserSession.new(role:)
    when "twitch"
      UserSession.new(role: Role.viewer)
    else
      # TODO: Remove the test hook maybe
      role = session.fetch("test.role", Role.anonymous).to_sym
      UserSession.new(role:)
    end
  end
end
