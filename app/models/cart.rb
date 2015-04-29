class Cart
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

  def to_money_string(price)
    "#{sprintf( "$%.02f" , (price.to_f/100))}"
  end

  def item_sub_total(item_id, quantity)
    quantity * Item.find(item_id).price
  end

  def cart_contents
    cart_info = {}
    contents.each_pair do |item_id, quantity|
      item = Item.find(item_id)
      cart_info[item] = []
      cart_info[item] << item.title
      cart_info[item] << to_money_string(item.price)
      cart_info[item] << quantity
      cart_info[item] << to_money_string(item_sub_total(item.id, quantity))
    end
    cart_info
  end

end