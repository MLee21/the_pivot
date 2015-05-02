require 'rails_helper'

RSpec.describe "Item", type: :model do 
  let(:item) { Item.new(title: "Fancy Hotdog", description: "Super fancy stuff", price: 300, )}
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

  scenario "title must be unique" do 
    item_1 = Item.create(title: "Fancy Hotdog", description: "Super fancy stuff", price: 300)
    item_2 = Item.create(title: "Fancy Hotdog", description: "Super fancy stuff", price: 300)

    expect(Item.count).to eq(1)
  end

  scenario "price must be an integer" do 
    item.price = "Dollar"

    expect(item).not_to be_valid
  end

  scenario "price must be greater than 0" do 
    item.price = 0

    expect(item).not_to be_valid
  end
end