require 'rails_helper'

RSpec.feature 'original business admin CRUD functionality for other admins' do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @business_admin = User.create(full_name:"MyName", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", role: 1, vendor_id: @vendor.id)
    @business_admin2 = User.create(full_name:"Admin", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", role: 1, vendor_id: @vendor.id)
    item = {title: "Squash", description: "It's good for you", price: 200}
    item2 = {title: "Melon", description: "It's good for you", price: 300}
    item3 = {title: "Strawberries", description: "It's good for you", price: 400}
    @vendor.items.create(item)
    @vendor.items.create(item2)
    @vendor.items.create(item3)
  end

  scenario 'with original admin logged in, admin can view all admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendor_admins_path(vendor: vendor.slug)
    expect(page).to have_content "Welcome, Admin!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).to have_content "Admin"
    expect(page).to have_link "Admin"
    expect(page).to have_content "busadmin@email.com"
    expect(page).to have_content "busadmin"
  end

  scenario 'with original admin logged in, admin can create admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendor_admins_path(vendor: vendor.slug)
    click_button "Create Admin"

    expect(current_path).to eq new_vendor_admin_path(vendor: vendor.slug)

    fill_in "Full Name", with: "Partnuh"
    fill_in "Display Name", with: "Partner"
    fill_in "Email", with: "Partnuh@admin.com"
### Password and roll should be set to a default password and 1 performed in the controller before save
    click_button "Submit"
    expect(current_path).to eq vendor_admins_path(vendor: vendor.slug)
    expect(page).to have_content "Welcome, Admin!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).to have_content "Partnuh"
    expect(page).to have_link "Partnuh"
    expect(page).to have_content "Partner"
    expect(page).to have_content "Partnuh@email.com"
  end

  scenario 'with original admin logged in, admin can update admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendor_admins_path(vendor: vendor.slug)

    expect(page).to have_content "Welcome, Admin!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).to have_content "Admin"
    expect(page).to have_link "Admin"
    expect(page).to have_content "busadmin@email.com"
    expect(page).to have_content "busadmin"
  ### Scope to secondary admin
    click_button "Update Admin"

    expect(current_path).to eq edit_vendor_admin_path(vendor: vendor.slug)

    fill_in "Full Name", with: "UpdatedAdmin"
    fill_in "Display Name", with: "Update"
    fill_in "Email", with: "update@admin.com"
  ### Password and roll should be set to a default password and 1 performed in the controller before save
    click_button "Submit"
    expect(current_path).to eq vendor_admins_path(vendor: vendor.slug)
    expect(page).to have_content "Welcome, Admin!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).to have_content "UpdatedAdmin"
    expect(page).to have_link "UpdatedAdmin"
    expect(page).to have_content "Update"
    expect(page).to have_content "update@email.com"
  end

  scenario 'with original admin logged in, admin can update admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendor_admins_path(vendor: vendor.slug)

    expect(page).to have_content "Welcome, Admin!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).to have_content "Admin"
    expect(page).to have_link "Admin"
    expect(page).to have_content "busadmin@email.com"
    expect(page).to have_content "busadmin"
### Scope to secondary admin
    click_button "Delete Admin"

    expect(current_path).to eq vendor_admins_path(vendor: vendor.slug)
    expect(page).not_to have_content "Admin"
    expect(page).not_to have_link "Admin"
    expect(page).not_to have_content "busadmin@email.com"
    expect(page).not_to have_content "busadmin"
  end
end
