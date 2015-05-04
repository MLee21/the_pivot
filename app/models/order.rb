class Order < ActiveRecord::Base

  validates :order_date, presence: true

  belongs_to :user
  belongs_to :status
  has_many :order_items
  has_many :items, through: :order_items

  include ContentReport

  def date
    order_date.to_date
  end

  def time
    order_date.strftime("%H:%M")
  end

  def total
    price = items.reduce(0) { |sum,item| sum += item.price }
    to_money_string(price)
  end

  def status
    Status.find(status_id).name
  end

  def item_count(item_id)
    items.where(id: item_id).count
  end

  def item_sub_total(item_id, quantity)
    quantity * items.find(item_id).price
  end

  def add_items(cart_contents, order)
    cart_contents.each_pair do |item_id, quantity|
      quantity.times do 
        order.items << Item.find(item_id)
      end
    end
  end

  def items_report
    report = {}
    items.each do |item|
      quantity = item_count(item.id)
      subtotal = to_money_string(item_sub_total(item.id, quantity))
      price    = to_money_string(item.price)
      report[item] = {price: price, quantity: quantity, subtotal: subtotal}
    end
    report
  end

  def self.generate_order(current_user)
    status = Status.find_by(name: "ordered")     
    new(order_date: Time.now, user_id: current_user.id, status_id: status.id )
  end

end
