class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :display_name, :email, :password)
  end

end