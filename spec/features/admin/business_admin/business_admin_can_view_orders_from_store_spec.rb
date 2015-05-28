require 'rails_helper'

RSpec.feature 'business admin can view orders' do

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
    @item1 = @vendor.items.create({title: "Melon", description: "It's good for you", price: 300})
    @item2 = @vendor.items.create({title: "Strawberries", description: "It's good for you", price: 400})
    @item3 = @vendor2.items.create({title: "Oranges", description: "It's good for you", price: 300})
    @item4 = @vendor2.items.create({title: "Bananas", description: "It's good for you", price: 400})
    @order.items << @item1
    @order.items << @item2
    @order2.items << @item3
    @order2.items << @item4
  end

  scenario 'Business admin can see all orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit admin_dashboard_path
    click_link "View Orders"
    page.select("completed", :from => "status_status_id")
    visit admin_orders_path
    expect(page).to have_content(@order.id)
    click_link @order.id
    expect(page).to have_content("Bobo")
    expect(page).to have_content("Melon")
    expect(page).to have_content("Strawberries")
    expect(page).to_not have_content("Bananas")
    expect(page).to_not have_content("Oranges")
  end

  scenario 'A different business admin can see all orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin2)
    visit admin_dashboard_path
    click_link "View Orders"
    page.select("completed", :from => "status_status_id")
    visit admin_orders_path
    expect(page).to have_content(@order2.id)
    click_link @order2.id
    expect(page).to have_content("Bowser")
    expect(page).to_not have_content("Melon")
    expect(page).to_not have_content("Strawberries")
    expect(page).to have_content("Bananas")
    expect(page).to have_content("Oranges")
  end

end