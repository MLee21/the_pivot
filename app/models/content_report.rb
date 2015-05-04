module ContentReport

  def to_money_string(price)
    "#{sprintf( "$%.02f" , (price.to_f/100))}"
  end

  def item_subtotal(item, quantity)
    quantity * item.price
  end

  def item_price(item)
    to_money_string(item.price)
  end

  def cart_parse(item, quantity)
    subtotal = item_subtotal(item, quantity)
    {subtotal: to_money_string(subtotal),
     price: item_price(item), 
     quantity: quantity
    }
  end

end