require "rails_helper"
# As a registered customer, upon logging in, I should be able to click on a link to view the list of registered businesses.
# When I click on one, I should be able to view the items and add the items to my cart.
# When I am ready to make my purchases, I can checkout.

feature "a registered customer can make purchases" do
  let!(:user) {User.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password", role: 0)}
  let!(:order) { create(:order) }

  let!(:status) { create(:status) }

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @item = {title: "Granny Smith Apple", description: "It's green", price: 100}
    @vendor.items.create(@item)
    order.status_id = status.id
    user.orders << order
  end

  scenario "registered customer can login in add items to cart and complete purchase" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    # redirected to vendor directory
    expect(current_path).to eq root_path
    # confirm vendor exists
    within '.main-nav' do
      click_link "Vendors"
    end
    expect(page).to have_content("Peter's Produce")
    # click vendor link
    click_link("Peter's Produce")
    # ? confirm vendor item directory path
    expect(current_path).to eq vendor_items_path(@vendor.slug)
    # confirm item exist
    expect(page).to have_content("Granny Smith Apple")
    # click Add to Basket
    click_button("Add to Basket")
    expect(page).to have_content("View Items in Cart (1)")
    # click cart
    click_link("View Items in Cart (1)")
    # confirm cart path
    expect(current_path).to eq cart_index_path
    # click complete order
    click_button("Complete Order")
    # confirm order path
    expect(current_path).to eq charges_path
    # confirm order
    expect(page).to have_content("Order successfully created!")
  end
end
