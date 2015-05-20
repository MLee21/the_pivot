class Vendors::VendorsController < ApplicationController
  helper_method :current_vendor
  before_action :vendor_not_found

  def current_vendor
    @current_vendor ||= Vendor.find_by(slug: params[:vendor])
  end

  def vendor_not_found
    redirect_to root_path unless current_vendor
  end
end
