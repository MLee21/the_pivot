require 'rails_helper'

feature 'business admin item CRUD functionality' do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @vendor2 = Vendor.create(name: "Nicholas Cage's Candies")
    @business_admin = BusinessAdministrator.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor)
    @business_admin2 = BusinessAdministrator.create(full_name:"Marilyn Manson", email: "Bloodbath@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor2)
    @vendor.items.create({title: "Squash", description: "It's good for you", price: 200})
    @vendor.items.create({title: "Melon", description: "It's good for you", price: 300})
    @vendor.items.create({title: "Strawberries", description: "It's good for you", price: 400})
    @vendor2.items.create({title: "OMG gummies", description: "Ah", price: 200})
  end

  scenario "an admin logs in and is redirected to view admin's vendor information" do
    visit root_path
    click_link "Login/Register"
    fill_in "session[email]", with: "Whatevs@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Peter's Produce")
    expect(page).to have_link("View Orders")
    expect(page).to have_link("Current Items")
    expect(page).to have_link("Manage Administrators")
    expect(page).to have_link("Edit Vendor Profile")
  end

  scenario "a business admin can only see their vendor information" do 
    visit root_path
    click_link "Login/Register"
    fill_in "session[email]", with: "Whatevs@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Peter's Produce")
    click_link "Current Items"
    expect(page).to have_content("Squash")
    expect(page).to have_content("Melon")
    expect(page).to have_content("Strawberries")
    expect(page).to_not have_content("OMG gummies")
  end 

  xscenario 'with admin logged in, admin can create items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendors_path
    click_link "Peter's Produce"
    expect(current_path).to eq vendor_admin_items_path(vendor)

    expect(page).to have_content("Peter's Produce")
    click_button "New Item"
    fill_in "Title", with: "Pumpkin"
    fill_in "Description", with: "Best pumpkins for pumpkin pie makin'"
    fill_in "Price", with: 500
    click_button "Create Item"

    expect(current_path).to eq vendor_admin_items_path(vendor)
    expect(page).to have_content("Squash")
    expect(page).to have_content("Pumpkin")
    expect(page).to have_link("Pumpkin")
    expect(page).to have_content("Best pumpkins for pumpkin pie makin'")
    expect(page).to have_content("$5.00")
  end

  xscenario 'with admin logged in, admin can edit items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendors_path
    click_link "Peter's Produce"
    expect(current_path).to eq vendor_admin_items_path(vendor)

    expect(page).to have_content("Peter's Produce")
    expect(page).to have_content("Squash")
    expect(page).to have_content("It's good for you")
    expect(page).to have_content("$2.00")
### Needs to be scoped to Edit for Squash
    click_button "Edit Item"
    fill_in "Title", with: "Tomato"
    fill_in "Description", with: "Don't squeeze 'em'"
    fill_in "Price", with: 50
    click_button "Update Item"

    expect(current_path).to eq vendor_admin_items_path(vendor)
    expect(page).not_to have_content("Squash")
    expect(page).to have_content("Tomato")
    expect(page).to have_link("Tomato")
    expect(page).not_to have_content("Best pumpkins for pumpkin pie makin'")
    expect(page).to have_content("Don't squeeze 'em'")
    expect(page).not_to have_content("$2.00")
    expect(page).to have_content("$.50")
  end

  xscenario 'with admin logged in, admin can edit items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@business_admin)
    visit vendors_path
    click_link "Peter's Produce"
    expect(current_path).to eq vendor_admin_items_path(vendor)

    expect(page).to have_content("Peter's Produce")
    expect(page).to have_content("Squash")
    expect(page).to have_content("It's good for you")
    expect(page).to have_content("$2.00")
### Needs to be scoped to Edit for Squash
    click_button "Delete Item"
    expect(page).not_to have_content("Peter's Produce")
    expect(page).not_to have_content("Squash")
    expect(page).not_to have_content("It's good for you")
    expect(page).not_to have_content("$2.00")
  end
end
