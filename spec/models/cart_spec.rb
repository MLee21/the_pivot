require 'rails_helper'

RSpec.describe "the cart" do

  let!(:item) { create(:item) }
  let!(:cart) { Cart.new({"#{item.id}" => 1}) }

  it "has initial contents" do
    expect(cart.contents).to eq({"#{item.id}" => 1})
  end

  it "can add an item" do
    cart.add_item(2, 3)
    expect(cart.contents).to eq({"#{item.id}" => 1, "2" => 3})
  end

  it "can count all items in cart" do
    cart.add_item(2, 3)
    expect(cart.count_all).to eq(4)
  end

  it "can return current contents" do
    expect(cart.current_contents).to eq({item => {:subtotal=>"$2.00", :price=>"$2.00", :quantity=>1}})
  end

  it "can remove and item" do
    cart.remove_item(item.id.to_s)
    expect(cart.contents).to eq({})
  end

  it "can return the total in a money format" do
    expect(cart.total).to eq("$2.00")
  end

end