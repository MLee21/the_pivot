class SessionsController < ApplicationController

  def new
    @login_page = true
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      if user.administrator?
        redirect_to admin_dashboard_path
      else
        redirect_to vendors_path
      end
    else
      flash[:errors] = "Invalid login"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
