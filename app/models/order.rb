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

  def prep_time
    items = self.items
    raw_time = bulk_order_delay(items) + paid_order_delay + item_prep_delay(items)
    format_prep_time(raw_time).join
  end

  def self.generate_order(current_user)
    status = Status.find_by(name: "ordered")     
    new(order_date: Time.now, user_id: current_user.id, status_id: status.id )
  end

  private

  def bulk_order_delay(items)
    time = ((items.size/6) - 1) * 10
    return time if time > 0
    0
  end

  def paid_order_delay
    Order.where(status_id: Status.paid_id).count * 4
  end

  def item_prep_delay(items)
    items.reduce(0) do |sum, item|
      sum += item.prep_time
    end
  end

  def format_prep_time(raw_time)
    time_string = []
    hours   = raw_time / 60
    minutes = raw_time % 60
    time_string << "#{hours} hour(s) " if hours > 0
    time_string << "#{minutes} minutes" 
  end

end
