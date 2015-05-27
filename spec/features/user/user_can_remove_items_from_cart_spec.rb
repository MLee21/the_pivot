require 'rails_helper'

RSpec.feature 'user removes items from cart' do

  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:category) { create(:category) }
  let!(:item) { create(:item) }

  xscenario 'as a logged in user' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit items_path

    expect(page).to have_content("Howdy, kulio!")
    expect(page).to have_content("Hotdog")
    click_link_or_button "Add to Basket"
    click_link_or_button "View Dogs in Cart (1)"
    expect(current_path).to eq(cart_index_path)

    expect(page).to have_content("View Dogs in Cart (1)")

    click_on "Remove"

    expect(page).to have_content("View Dogs in Cart (0)")
  end
end
