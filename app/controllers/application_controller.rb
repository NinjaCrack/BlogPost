class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  def current_user # Retrieve the currently logged-in user based on the session user_id
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in? # Check if a user is logged in
    current_user.present?
  end

  def require_login # Ensure that a user is logged in before accessing certain actions
    redirect_to login_path, alert: "You must be logged in to access this section" unless logged_in?
  end
  
end
