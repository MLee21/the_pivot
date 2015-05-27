class Admin::VendorsController < Admin::BaseController

  def index

  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

end
