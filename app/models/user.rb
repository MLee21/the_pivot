class User < ActiveRecord::Base
  validates :full_name, presence: true
  validates :email, uniqueness: true, presence: true, email_format: { message: 'is not looking good'}
  validates :display_name, length: { in: 2..32 }, allow_blank: true

  has_many :orders

  has_secure_password

  enum role: ["default", "admin"]

  def admin?
    role == "admin"
  end

  def display?
    display_name && display_name != ""
  end

  def any_orders?
    orders.size > 0
  end

  def orders_by_status
    order_counts = {"ordered" => 0, "paid" => 0, "cancelled" => 0, "complete" => 0}
    orders.each do |order|
      order_counts[order.status] += 1
    end
    order_counts
  end

  def name_to_display
    display_name.presence || full_name
  end
end
