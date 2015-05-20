require "rails_helper"
# As a registered customer, upon logging in, I should be able to click on a link to view the list of registered businesses.
# When I click on one, I should be able to view the items and add the items to my cart.
# When I am ready to make my purchases, I can checkout.

feature "a registered customer can make purchases" do
  let!(:user) {User.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")}
  let!(:vendor) {create(:vendor)}
  let!(:item) {create(:item)}

  scenario "registered customer can login in add items to cart and complete purchase" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    # redirected to vendor directory
    expect(current_path).to eq vendors_path
    # confirm vendor exists
    expect(page).to have_content("Peter's Produce")
    # click vendor link
    click_link("Peter's Produce")
    # ? confirm vendor item directory path
    expect(current_path).to eq vendor_items_path(vendor)
    # confirm item exist
    expect(page).to have_content("Granny Smith Apple")
    # click Add to Basket
    within(".item-class:first") do
      click_link("Add to Basket")
    end
    expect(page).to have_content("View Dogs in Cart (1)")
    # click cart
    click_link("View Dogs in Cart (1)")
    # confirm cart path
    expect(current_path).to eq cart_path
    # click complete order
    click_link("Complete Order")
    # confirm order path
    expect(current_path).to eq charge_path
    # confirm order
    expect(page).to have_content("Order successfully created!")
  end
end
