class Order < ActiveRecord::Base
  validates :order_date, presence: true

  belongs_to :user
  belongs_to :status
  has_many :order_items
  has_many :items, through: :order_items

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

  def item_sub_total(item_id)
    item_count(item_id) * items.find(item_id).price
  end

  def to_money_string(price)
    "#{sprintf( "$%.02f" , (price.to_f/100))}"
  end

  def items_report
    report = {}
    items.each do |item|
      report[item] = []
      report[item] << item.title
      report[item] << to_money_string(item.price)
      report[item] << item_count(item.id)
      report[item] << to_money_string(item_sub_total(item.id))
    end
    report
  end

end
