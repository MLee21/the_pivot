class Admin::OrdersController < Admin::BaseController
 
  def index
    @order_counts = current_user.orders_by_status
    if params.has_key?(:status)
      @orders = Status.find(params[:status][:status_id]).orders
      @list   = Status.find(params[:status][:status_id]).name
    else
      @orders = Order.all
      @list   = "all orders"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(order_params[:id])
    status_id = Status.find_by(name: order_params[:change]).id

    if order.update(status_id: status_id)
      flash[:notice] = "Status updated."
    else
      flash[:errors] = order.errors.full_messages.join(", ")
    end
      redirect_to admin_orders_path
  end

  private

  def order_params
    params.permit(:change, :id)
  end

end
