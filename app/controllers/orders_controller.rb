class OrdersController < ApplicationController

  def index
    @order_counts = current_user.orders_by_status
    if params.has_key?(:status)
      @orders = Status.find(params[:status][:status_id]).orders.where(user_id: current_user.id)
      @list   = Status.find(params[:status][:status_id]).name
    else
      @orders = current_user.orders
      @list   = "all orders"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

end
