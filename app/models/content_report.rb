module ContentReport

  def to_money_string(price)
    "#{sprintf( "$%.02f" , (price.to_f/100))}"
  end

end