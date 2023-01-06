class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user

  def current_user
    User.new(role: :broadcaster)
  end
end
