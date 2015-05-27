class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    owner?(params[:id].to_i)
  end

  def edit
    owner?(params[:id].to_i)
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to cart_index_path
    else
      flash[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params) && @user.authenticate(user_params[:password])
      redirect_to root_path
    else
      flash[:errors] = "Invalid updates"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :display_name, :email, :password)
  end

end