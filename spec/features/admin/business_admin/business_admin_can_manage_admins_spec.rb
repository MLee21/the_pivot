require 'rails_helper'

RSpec.feature 'business admin CRUD functionality for secondary admins' do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @business_admin = BusinessAdministrator.create(full_name:"Buttercup", email: "seymourbutts@gmail.com", password:"password", password_confirmation: "password", vendor_id: @vendor.id)
    @business_admin2 = BusinessAdministrator.create(full_name:"Joe Bob", email: "bobo@gmail.com", password:"password", password_confirmation: "password", vendor_id: @vendor.id)
    item = {title: "Squash", description: "It's good for you", price: 200}
    item2 = {title: "Melon", description: "It's good for you", price: 300}
    item3 = {title: "Strawberries", description: "It's good for you", price: 400}
    @vendor.items.create(item)
    @vendor.items.create(item2)
    @vendor.items.create(item3)
  end

  scenario 'with secondary admin logged in, admin can not view all admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin2)
    visit admin_dashboard_path
    expect(page).to_not have_content("Manage Administrators")
  end

  scenario 'with secondary admin logged in, admin can update vendor account' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin2)
    visit admin_dashboard_path
    expect(page).to have_content "Howdy, Joe Bob!"
    click_link "Edit Vendor Profile"
    fill_in "vendor[name]", with: "Butt's Butts"
    click_button "Update"
    expect(current_path).to eq(admin_dashboard_path)
  end

  xscenario 'with secondary admin logged in, admin can update their own account' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendor_admin_path(vendor: vendor.slug)

    expect(page).to have_content "Welcome, MyName!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).not_to have_link "Delete Admin"
  end
end
