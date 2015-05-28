class Admin::VendorsController < Admin::BaseController

  def index
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update(admin_vendor_params)
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  private

  def admin_vendor_params
    params.require(:vendor).permit(:name)
  end
end
