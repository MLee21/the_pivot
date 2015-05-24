class Admin::OrdersController < Admin::BaseController

  def index
    @order_counts = current_user.orders_by_status
    if params.has_key?(:status)
      @orders = Status.find(params[:status][:status_id]).orders.where(vendor_id: current_user.vendor_id)
      @list   = Status.find(params[:status][:status_id]).name
    else
      @orders = Order.all.where(vendor_id: current_user.vendor_id)
      @list   = "all orders"
    end
  end

  def show
    @order   = Order.find(params[:id])
    @user    = User.find(@order.user_id)
    @details = @order.items_report(@order.id)
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
