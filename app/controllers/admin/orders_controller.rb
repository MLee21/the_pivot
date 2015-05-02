class Admin::OrdersController < ApplicationController
  before_action :ensure_admin_user
  def show
    @order = Order.find(params[:id])
  end

end
