class Oracle

  def initialize(user)
    @user = user
  end

  def items
    @user.platform_administrator? ? Item.all : @user.vendor.items
  end

  def categories
    @user.platform_administrator? ? Category.all : @user.vendor.categories
  end

  def orders
    @user.platform_administrator? ? Order.all : @user.vendor.orders
  end

end