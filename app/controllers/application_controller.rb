class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :howdy_name
  helper_method :current_admin?
  helper_method :hot_dog_categories

  def howdy_name
    return current_user.display_name if current_user && current_user.display_name
    return current_user.full_name    if current_user
    "Guest"
  end

  def hot_dog_categories
    Category.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      flash[:errors] = "Please log in"
      redirect_to login_path
    end
  end

end
