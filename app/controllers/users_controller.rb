class UsersController < ApplicationController

  def new
    @user = RegisteredUser.new
  end

  def show
    owner?(params[:id].to_i)
  end

  def edit
    owner?(params[:id].to_i)
    @user = RegisteredUser.find(params[:id])
  end

  def create
    @user = RegisteredUser.new(user_params)
    if @user.save
      OrderMailer.order_notification_to_admin(@user).deliver
      session[:user_id] = @user.id
      redirect_to cart_index_path
    else
      flash[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @user = RegisteredUser.find(current_user.id)
    if @user.update(user_params) && @user.authenticate(user_params[:password])
      redirect_to root_path
    else
      flash[:errors] = "Invalid updates"
      render :edit
    end
  end

  private

  def user_params
    params.require(:registered_user).permit(:full_name, :display_name, :email, :password)
  end

end