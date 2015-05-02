class Admin::OptionsController < Admin::BaseController

  def route
    option = params[:option][:option_type]
    redirect_to admin_items_path            if option == "items"
    redirect_to admin_orders_path     if option == "orders"
    redirect_to admin_categories_path if option == "categories"
  end

end