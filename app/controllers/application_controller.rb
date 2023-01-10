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
    role = session.fetch(:role, :anonymous).to_sym
    UserSession.new(role:)
  end
end
