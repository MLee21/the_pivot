class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all
  end

  def show
    
  end

end
