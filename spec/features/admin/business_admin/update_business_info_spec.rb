require 'rails_helper'

feature 'business admin can update business information' do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @business_admin = BusinessAdministrator.create(full_name:"MyName", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor_id: @vendor.id)
    item = {title: "Squash", description: "It's good for you", price: 200}
    item2 = {title: "Melon", description: "It's good for you", price: 300}
    item3 = {title: "Strawberries", description: "It's good for you", price: 400}
    @vendor.items.create(item)
    @vendor.items.create(item2)
    @vendor.items.create(item3)
  end

  scenario 'when business admin logs in, admin can edit business info' do
    visit root_path
    click_link "Login/Register"
    fill_in "session[email]", with: "Whatevs@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"

    expect(current_path).to eq(admin_dashboard_path)
    click_link "Edit Vendor Profile"
    expect(current_path).to eq(edit_admin_vendor_path(@vendor))

    fill_in "Name", with: "Bob's Burgers"
    click_button "Update"

    expect(page).to have_content "Vendor successfully updated."
    expect(page).to have_content "Bob's Burgers"
    expect(current_path).to eq(admin_dashboard_path)
  end

  scenario 'when business admin unsuccessfully logs in, admin is redirected to update form' do
    visit root_path
    click_link "Login/Register"
    fill_in "session[email]", with: "Whatevs@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"

    expect(current_path).to eq(admin_dashboard_path)
    click_link "Edit Vendor Profile"
    expect(current_path).to eq(edit_admin_vendor_path(@vendor))

    fill_in "Name", with: "Bob"
    click_button "Update"

    expect(page).to have_content "Name is too short (minimum is 4 characters)"
    expect(current_path).to eq(edit_admin_vendor_path(@vendor))
  end
end
