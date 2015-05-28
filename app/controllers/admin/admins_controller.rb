class Admin::AdminsController < Admin::BaseController

  def index
    @admins = User.where(vendor_id: current_user.vendor.id)
  end

  def new
    @admin = BusinessAdministrator.new
  end

  def create
    @admin = BusinessAdministrator.new(business_administrator_params)
    @admin.update_attributes(vendor: current_user.vendor)
    if @admin.save
      redirect_to admin_admins_path
    else
      flash[:error] = @admin.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @admin = User.find(params[:id])
  end

  def update
    @admin = User.find(params[:id])
    if @admin.update(business_administrator_params)
      flash[:notice] = "Business Administrator has been updated!"
      redirect_to admin_admins_path
    else
      flash[:error] = @admin.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def business_administrator_params
    params.require(:business_administrator).permit(:full_name, :display_name, :password, :email)
  end

end