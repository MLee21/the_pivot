require 'rails_helper'

RSpec.describe "Item", type: :model do 
  
  let(:item) { create(:item) }
  
  it "is a valid item" do 
    expect(item).to be_valid
  end

  it "is invalid without title" do 
    item.title = nil
    expect(item).not_to be_valid
  end

  it "is invalid when title is empty string" do 
    item.title = ""
    expect(item).not_to be_valid
  end

  it "is invalid without a description" do 
    item.description = nil
    expect(item).not_to be_valid
  end

  it "is invalid when description is empty string" do 
    item.description = ""
    expect(item).not_to be_valid
  end

  it "title must be unique" do 
    item_2 = Item.create(title: "Hotdog", description: "Super fancy stuff", price: 300)
    expect(Item.count).to eq(1)
  end

  it "price must be an integer" do 
    item.price = "Dollar"
    expect(item).not_to be_valid
  end

  it "price must be greater than 0" do 
    item.price = 0
    expect(item).not_to be_valid
  end

  it "is not discontinued" do 
    expect(item.discontinued?).to eq(false)
  end

  it "is can be discontinued" do 
    item.discontinue = true
    expect(item.discontinued?).to eq(true)
  end

  it "can format a price for the database" do
    item.format_price(5.00)
    expect(item.price).to eq(500)
  end

  it "can add a 'all' category to an item" do
   category = Category.create(name: "All Dogs") 
   item.add_all_category
   expect(item.categories).to eq([category])
  end

  it "returns a list of categories for an item" do 
    category = Category.create(name: "All Dogs") 
    item.add_all_category
    expect(item.category_list).to eq(["All Dogs"])
  end

  it "can adjust information for the database" do
    category = Category.create(name: "All Dogs") 
    item.adjust_information(5.00)
    expect(item.price).to eq(500)
    expect(item.categories).to eq([category])
  end

end