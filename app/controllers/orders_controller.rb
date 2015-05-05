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
    @order   = Order.find(params[:id])
    @details = @order.items_report
    owner?(@order.user_id)
  end

  def create
    order  = Order.generate_order(current_user)
    order.add_items(session[:cart], order)

    if order.save
      flash[:notice] = "Order successfully created!"
      session[:cart] = nil
      redirect_to order_path(order)
    else
      flash[:errors] = order.errors.full_messages.join(", ")
      redirect_to cart_index_path
    end
  end

end
