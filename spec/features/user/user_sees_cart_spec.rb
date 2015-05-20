require 'rails_helper'

RSpec.feature "user sees all items in cart" do

  let!(:user)     { create(:user) }
  let!(:category) { create(:category) }
  let!(:status)   { create(:status) }
  let!(:item)     { create(:item) }

  scenario "guest user sees one item in cart" do
    visit items_path

    click_link_or_button "Add to Basket"
    click_link_or_button "View Dogs in Cart (1)"

    expect(page).to have_content "Hotdog"
    expect(page).to have_content "1"
    expect(page).to have_content "$2.00"
  end

  scenario "authenticated user checks out" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit items_path
    
    click_link_or_button "Add to Basket"
    click_link_or_button "View Dogs in Cart (1)"
    
    expect(page).to have_content "Total: $2.00"
    
    click_button "Login to buy dogs!"
    fill_in "session[email]", with: "example@email.com"
    fill_in "session[password]", with: "p"
    click_button "Submit"

    click_link_or_button "View Dogs in Cart (1)"

    expect(page).to have_content "Title"
    expect(page).to have_content "Price"
    expect(page).to have_button "Complete Order"
  end

end
