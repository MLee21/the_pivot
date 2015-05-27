class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find_by(slug: params[:slug])
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      flash[:notice] = "Vendor successfully updated."
      redirect_to admin_dashboard_path
    else
      flash[:error] = vendor.errors.full_messages.join(', ')
      redirect_to edit_admin_vendor_path
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name)
  end
end
