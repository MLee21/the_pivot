class ChargesController < ApplicationController

  def index
    @order       = current_user.orders.last
    @in_dollars  = @order.total 
    @in_cents    = @order.total_in_cents.to_s
    @user        = User.find(@order.user_id)
    @details     = @order.items_report(@order.id)
    @prep_time   = session[:prep_time]
    owner?(@order.user_id) 
  end

  def create
    @order = current_user.orders.last

    customer = Stripe::Customer.create(
      email: stripe_params[:stripeEmail],
      card:  stripe_params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @order.total_in_cents,
      description:  "Cowboy Kyle's",
      currency:     "usd"
    )

    @order.set_status_to_paid if charge

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end 

  private

  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end

end