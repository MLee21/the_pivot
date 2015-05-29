require 'rails_helper'

RSpec.feature 'original business admin CRUD functionality for other admins' do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @business_admin = BusinessAdministrator.create(full_name:"MyName", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor_id: @vendor.id)
    @business_admin2 = BusinessAdministrator.create(full_name:"Admin", email: "admin@email.com", password:"password", password_confirmation: "password", vendor_id: @vendor.id)
    item = {title: "Squash", description: "It's good for you", price: 200}
    item2 = {title: "Melon", description: "It's good for you", price: 300}
    item3 = {title: "Strawberries", description: "It's good for you", price: 400}
    @vendor.items.create(item)
    @vendor.items.create(item2)
    @vendor.items.create(item3)
  end

  scenario 'with original admin logged in, admin can view all admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit admin_dashboard_path
    click_link "Manage Administrators"
    expect(current_path).to eq(admin_admins_path)
    expect(page).to have_content "Howdy, MyName!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "Admin"
    expect(page).to have_link "Admin"
    expect(page).to have_content "admin@email.com"
  end

  scenario 'with original admin logged in, admin can create admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit admin_dashboard_path
    click_link "Manage Administrators"
    click_button "Create Admin"

    expect(current_path).to eq new_admin_admin_path
    fill_in "business_administrator[full_name]", with: "Partnuh"
    fill_in "business_administrator[display_name]", with: "Partner"
    fill_in "business_administrator[email]", with: "Partnuh@admin.com"
    fill_in "business_administrator[password]", with: "Password"
    fill_in "business_administrator[password_confirmation]", with: "Password"

    click_button "Create Business Administrator"

    expect(current_path).to eq admin_admins_path
    expect(page).to have_content "Howdy, MyName!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"
    expect(page).to have_content "Partnuh"
    expect(page).to have_content "Partnuh@admin.com"
  end

  xscenario 'with original admin logged in, admin can update admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit admin_dashboard_path
    click_link "Manage Administrators"
    within "#admins_list li:nth-child(5)" do
      click_link("Edit Admin")
    end
    expect(current_path).to eq(edit_admin_admin_path(@business_admin2))
    fill_in "business_administrator[full_name]", with: "UpdatedAdmin"
    fill_in "business_administrator[display_name]", with: "Update"
    fill_in "business_administrator[email]", with: "update@admin.com"
    click_button "Update Admin"
    expect(current_path).to eq(admin_admins_path)
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "UpdatedAdmin"
    expect(page).to have_link "UpdatedAdmin"
    expect(page).to have_content "Update"
    expect(page).to have_content "update@admin.com"
  end

end
