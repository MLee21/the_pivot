require 'rails_helper'

RSpec.describe "an order" do

  let!(:order)  { create(:order) }
  let!(:status) { create(:status) }
  let!(:user)   { create(:user) }
  let!(:item)   { create(:item) }

  before(:each) do
    order.user_id = user.id
    order.status_id = status.id
    order.items << item
  end

  it "is valid with an order date" do
    expect(order).to be_valid
  end

  it "is invalid without an order date" do
    order.order_date = nil
    expect(order).to_not be_valid
  end

  it "has item(s)" do
    expect(order.items).to eq([item])    
  end

  it "can convert a date string to datetime" do
    date = order.date.class
    expect(date).to eq(Date)
  end

  it "can convert a date string to time string" do
    time = order.time
    expect(time).to eq("00:00")
  end

  it "can calculate the total" do
    expect(order.total).to eq("$2.00")
  end

  it "can calculate total in cents" do
    expect(order.total_in_cents).to eq(200)
  end

  it "can count the number of an item" do
    expect(order.item_count(item.id)).to eq(1)
    expect(order.item_count("0")).to eq(0)
  end  

  it "can add items from the cart" do
    cart_contents = { "#{item.id}" => 1 }
    added = order.add_items(cart_contents, order)
    expect(order.items.count).to eq(2)
  end

  it "sets status to paid" do
    status.name = "paid"
    status.save
    order.set_status_to_paid
    expect(order.status_id).to eq(status.id)
  end

  it "calculates a prep time" do
    status.name = "paid"
    status.save
    expect(order.prep_time).to eq("12 minutes")
  end

end