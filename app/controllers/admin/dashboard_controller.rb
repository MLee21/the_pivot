class Admin::DashboardController < Admin::BaseController

  def index
    if current_user.business_administrator?
      @vendor = current_user.vendor
      render :business_dashboard
    else
      @vendors = Vendor.all
      render :platform_dashboard
    end
  end

end
