require "rails_helper"

feature "a registered customer can make purchases" do
  let!(:user) {RegisteredUser.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")}
  let!(:order) { create(:order) }
  let!(:status) { create(:status) }

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @vendor2 = Vendor.create(name: "Jim's Juices")
    @business_admin = BusinessAdministrator.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor)
    @business_admin2 = BusinessAdministrator.create(full_name:"Felicia Eyebrows", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor2)
    @user = RegisteredUser.create(full_name:"Bobo", password: "yolo", password_confirmation: "yolo", email:"bobo@gmail.com")
    @user2 = RegisteredUser.create(full_name:"Bowser", password: "yolo", password_confirmation: "yolo", email:"bowser@gmail.com")
    @status = Status.create(name:"completed")
    @order = @user.orders.create(status_id: @status.id, order_date: Time.now, vendor_id: @vendor.id)
    @order2 = @user2.orders.create(status_id: @status.id, order_date: Time.now, vendor_id: @vendor2.id)
    @item = {title: "Granny Smith Apple", description: "It's green", price: 100}
    @item1 = @vendor.items.create({title: "Melon", description: "It's good for you", price: 300})
    @order.items << @item1
  end



  scenario "registered customer can login in add items to cart and complete purchase" do
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    expect(current_path).to eq(vendors_path)
    within '.main-nav' do
      click_link "Vendors"
    end
    expect(page).to have_content("Peter's Produce")
    click_link("Peter's Produce")
    expect(current_path).to eq vendor_items_path(@vendor.slug)
    expect(page).to have_content("Melon")
    click_button("Add to Basket")
    expect(page).to have_content("View Items in Basket (1)")
    click_link("View Items in Basket (1)")
    expect(current_path).to eq cart_index_path

  end
end
