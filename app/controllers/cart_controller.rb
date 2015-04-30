class CartController < ApplicationController

  def index
    @contents = @cart.current_contents
    @total    = @cart.total
  end

  def create
    item     = Item.find(params[:order][:item_id])
    quantity = params[:order][:quantity]
    @cart.add_item(item.id, quantity)
    session[:cart] = @cart.contents
    redirect_to items_path
  end

  def update
    item_id = adjust_cart_params[:id]
    session[:cart][item_id] += 1 if adjust_cart_params[:adjust] == "increase"
    session[:cart][item_id] -= 1 if adjust_cart_params[:adjust] == "decrease"  
    redirect_to cart_index_path
  end

  def destroy
    @cart.remove_item(params[:id])
    redirect_to cart_index_path
  end

  private

  def adjust_cart_params
    params.permit(:id, :adjust)
  end

end