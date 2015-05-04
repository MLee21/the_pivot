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

  def current_contents
    cart_info = {}
    contents.each_pair do |item_id, quantity|
      item     = Item.find(item_id.to_i)
      cart_info[item] = cart_parse(item, quantity)
    end
    sanitize(cart_info)
  end

  def remove_item(remove_id)
    @contents.reject! { |item_id, quantity| remove_id == item_id }
  end

  def total
    total = contents.reduce(0) do |total, (item_id, quantity)|
      item = Item.find(item_id.to_i)
      total += item_subtotal(item, quantity)
    end
    to_money_string(total)
  end

  private

  def sanitize(cart_info)
    cart_info.reject { |item_id, data| data[:quantity] <= 0 }
  end

end