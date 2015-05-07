require 'rails_helper'

RSpec.describe "a category" do

  let!(:category) { create(:category) }
  let!(:item) { create(:item) }

  it "is invalid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "is valid with a name" do
    expect(category).to be_valid
  end

  it "has item(s)" do
    item.categories << category
    expect(category.items).to eq([item])
  end

end