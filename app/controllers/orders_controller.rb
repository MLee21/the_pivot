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

  def create
    status = Status.find_by(name: "ordered")     
    order  = Order.new(order_date: Time.now, user_id: current_user.id, status_id: status.id )
    
    session[:cart].each_pair do |item_id, quantity|
      quantity.times do 
        order.items << Item.find(item_id)
      end
    end

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
