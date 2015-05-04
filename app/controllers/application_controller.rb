class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :load_cart, :howdy_name, 
                :current_admin?, :hotdog_categories, :logged_in?,
                :show_available_items

  before_action :load_cart

  def load_cart
    @cart ||= Cart.new(session[:cart])
  end

  def hotdog_categories
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

  def ensure_admin_user
    unless current_user.admin?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
