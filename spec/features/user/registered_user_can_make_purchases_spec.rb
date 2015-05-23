require "rails_helper"

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
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    expect(current_path).to eq root_path
    within '.main-nav' do
      click_link "Vendors"
    end
    expect(page).to have_content("Peter's Produce")
    click_link("Peter's Produce")
    expect(current_path).to eq vendor_items_path(@vendor.slug)
    expect(page).to have_content("Granny Smith Apple")
    click_button("Add to Basket")
    expect(page).to have_content("View Items in Cart (1)")
    click_link("View Items in Cart (1)")
    expect(current_path).to eq cart_index_path
    click_button("Complete Order")
    expect(current_path).to eq charges_path
    expect(page).to have_content("Order successfully created!")
  end
end
