class ApplicationController < ActionController::Base
  include Pundit
  helper_method :require_user

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  private

  def require_user
    redirect_to new_user_session_path unless current_user
  end
end
