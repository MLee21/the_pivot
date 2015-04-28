class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :howdy_name, :current_admin?, :hot_dog_categories, :logged_in?

  def hot_dog_categories
    Category.all
  end

  def current_user
    @current_user ||= user_from_session || Guest.new
  end

  def logged_in?
    session[:user_id].present?
  end

  def logged_in_user
    unless logged_in?
      flash[:errors] = "Please log in"
      redirect_to login_path
    end
  end

  private

  def user_from_session
    if session[:user_id]
      User.find_by(id: session[:user_id])
    end
  end
end
