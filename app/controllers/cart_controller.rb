class CartController < ApplicationController

  def index
    @contents = @cart.cart_contents
  end

  def create
    item     = Item.find(params[:order][:item_id])
    quantity = params[:order][:quantity]
    @cart.add_item(item.id, quantity)
    session[:cart] = @cart.contents
    redirect_to items_path
  end

end