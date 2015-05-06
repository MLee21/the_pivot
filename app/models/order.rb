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
    to_money_string(total_in_cents)
  end

  def total_in_cents
    items.reduce(0) { |sum,item| sum += item.price }
  end

  def item_count(item_id)
    items.where(id: item_id).count
  end

  def add_items(cart_contents, order)
    cart_contents.each_pair do |item_id, quantity|
      quantity.times do 
        order.items << Item.find(item_id)
      end
    end
  end

  def items_report(order_id)
    report = {}
    order_items.where(order_id: order_id).each do |order_item|
      quantity     = order_items.where(item_id: order_item.item_id).count
      item         = Item.unscoped.find(order_item.item_id)
      report[item] = cart_parse(item, quantity)
    end
    report
  end

  def set_status_to_paid
    status_id       = Status.paid_id
    self.status_id = status_id
    self.save
  end

  def self.generate_order(current_user)
    status = Status.find_by(name: "ordered")     
    new(order_date: Time.now, user_id: current_user.id, status_id: status.id )
  end

end
