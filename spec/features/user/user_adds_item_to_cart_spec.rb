require 'rails_helper'

RSpec.feature "user adds items to cart" do

  let!(:user)     { create(:user) }
  let!(:category) { create(:category) }
  let!(:item)     { create(:item) }

  scenario "as a guest user from the items index" do
    visit items_path

    expect(page).to have_content("Hotdog")
    click_link_or_button "Add to Cart"
    expect(page).to have_content("View Dogs in Cart (1)")

    fill_in "order[quantity]", with: "3"

    click_link_or_button "Add to Cart"
    expect(page).to have_content("View Dogs in Cart (4)")
  end

  scenario "as a logged in user from the items index" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit items_path

    expect(page).to have_content("Howdy, kulio!")    
    expect(page).to have_content("Hotdog")

    click_link_or_button "Add to Cart"

    expect(page).to have_content("View Dogs in Cart (1)")

    fill_in "order[quantity]", with: "3"

    click_link_or_button "Add to Cart"

    expect(page).to have_content("View Dogs in Cart (4)")
  end

  scenario "as a logged in user from the item path" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit item_path(item)

    expect(page).to have_content("Hotdog")

    fill_in "order[quantity]", with: "3"
    click_link_or_button "Add to Cart"

    expect(page).to have_content("View Dogs in Cart (3)")
  end

end