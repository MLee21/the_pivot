class Vendors::ItemsController < Vendors::VendorsController

  def index
    @items = current_vendor.items
  end

  def show
    @item = current_vendor.items.find_by(params[:item_id])
  end
end
