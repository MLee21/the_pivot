require 'rails_helper'

feature 'business admin item CRUD functionality' do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @vendor2 = Vendor.create(name: "Nicholas Cage's Candies")
    @business_admin = BusinessAdministrator.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor)
    @business_admin2 = BusinessAdministrator.create(full_name:"Marilyn Manson", email: "Bloodbath@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor2)
    category = Category.create(name: "Organic")
    item = @vendor.items.create({title: "Squash", description: "It's good for you", price: 200})
    item.categories << category 
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

  scenario 'with admin logged in, admin can create items' do
    visit root_path
    click_link "Login/Register"
    fill_in "session[email]", with: "Whatevs@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Peter's Produce")
    click_link "Current Items"
    click_button "Create New Item"
    fill_in "Title", with: "Pumpkin"
    fill_in "Description", with: "Best pumpkins for pumpkin pie makin'"
    fill_in "Price ($)", with: 5.00
    click_button "Create Item"

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Squash")
    expect(page).to have_content("Pumpkin")
    expect(page).to have_content("$5.00")
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end

  scenario 'with admin logged in, admin can edit items' do
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
    expect(page).to have_content("$2.00")
    first('.item_box').click_link('Edit')
    fill_in "Title", with: "Tomato"
    fill_in "Description", with: "Don't squeeze 'em'"
    fill_in "Price", with: 0.50
    click_button "Update"

    expect(current_path).to eq(admin_items_path)
    expect(page).not_to have_content("Squash")
    expect(page).to have_content("Tomato")
    expect(page).to have_link("Tomato")
    expect(page).not_to have_content("Best pumpkins for pumpkin pie makin'")
    expect(page).not_to have_content("$2.00")
    expect(page).to have_content("$0.50")
  end
end
