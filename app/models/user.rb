class User < ActiveRecord::Base
  validates :full_name, presence: true
  validates :email, uniqueness: true, presence: true, email_format: { message: 'is not looking good'}
  validates :display_name, length: { in: 2..32 }, allow_blank: true

  has_many :orders
  has_secure_password

  def administrator?
    business_administrator? || platform_administrator?
  end

  def business_administrator?
    is_a? BusinessAdministrator 
  end

  def registered_user?
    is_a? RegisteredUser 
  end

  def platform_administrator?
    is_a? PlatformAdministrator
  end

  def display?
    display_name && display_name != ""
  end

  def name_to_display
    display_name.presence || full_name
  end

  def orders_by_status
    if administrator?
      order_list = Order.all
    else
      order_list = orders
    end
    {"cancelled" => count(order_list, "cancelled"),
     "completed"  => count(order_list, "completed"),
     "ordered"   => count(order_list, "ordered"), 
     "paid"      => count(order_list, "paid")
    }
  end

  private

  def count(orders, status, count = 0)
    orders.each do |order| 
      count += 1 if order.status.name == status
    end
    count
  end

end
