require 'rails_helper'

RSpec.feature "user adds items to cart" do

  let(:vendor)   { create(:vendor) }
  let(:user)     { create(:user) }
  let(:category) { create(:category) }
  let(:item)     { create(:item) }

  xscenario "as a logged in user from the home page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to have_content("Howdy, kulio!")
    within 'nav' do
      expect(page).to have_link("Vendors")
    end
    click_link "Vendors"
    click_link "Peter's Produce"
    expect(current_route).to eq(vendor_path(vendor))
    click_link_or_button "Add to Basket"

    expect(page).to have_content("View Items in Cart (1)")

    click_link "Vendors"
    click_link "Pretzel Hut"
    expect(current_route).to eq(vendor_path(vendor))
    click_link_or_button "Add to Basket"

    expect(page).to have_content("View Items in Cart (2)")
  end

  xscenario "as a logged in user from the item path" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit item_path(item)

    expect(page).to have_content("Squash")

    fill_in "order[quantity]", with: "3"
    click_link_or_button "Add to Basket"

    expect(page).to have_content("View Items in Cart (3)")
  end

end
