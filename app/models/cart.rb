class Cart 

  include ContentReport

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item_id, quantity)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += quantity.to_i
  end

  def count_all
    contents.values.sum
  end

  def item_sub_total(item_id, quantity)
    quantity * Item.find(item_id).price
  end

  def current_contents
    cart_info = {}
    contents.each_pair do |item_id, quantity|
      item     = Item.find(item_id.to_i)
      subtotal = to_money_string(item_sub_total(item.id, quantity))
      cart_info[item] = {quantity: quantity, subtotal: subtotal}
    end
    sanitize(cart_info)
  end

  def remove_item(remove_id)
    @contents.reject! { |item_id, quantity| remove_id == item_id }
  end

  def total
    total = contents.reduce(0) do |total, (item_id, quantity)|
      total += item_sub_total(item_id.to_i, quantity)
    end
    to_money_string(total)
  end

  private

  def sanitize(cart_info)
    cart_info.reject { |item_id, data| data[:quantity] <= 0 }
  end

end