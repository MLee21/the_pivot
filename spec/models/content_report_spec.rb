require 'rails_helper'

RSpec.describe "content report functions" do

  let!(:item) { create(:item) }

  it "converts an integer to a money string" do
    result = item.to_money_string(500)
    expect(result).to eq("$5.00")
  end

  it "converts an integer to a 2 decimal value" do
    result = item.to_money_decimal(500)
    expect(result).to eq("5.00")
  end

  it "calculates a sub total" do
    result = item.item_subtotal(item, 2)
    expect(result).to eq(400)
  end

  it "returns cart information" do
    result = item.cart_parse(item, 1)
    expect(result).to eq( {subtotal: "$2.00",
                           price: "$2.00",
                           quantity: 1 })
  end

end