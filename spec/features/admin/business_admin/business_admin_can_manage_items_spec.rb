require 'rails_helper'

RSpec.feature 'business admin item CRUD functionality' do

  let!(:admin)    { create(:admin) }
  let!(:item)     { create(:item) }
  let!(:status)   { create(:status) }
  let!(:vendor)   { create(:vendor) }
  # let!(:category) { create(:category) }

  context 'with admin logged in, admin can view items' do
    allow_any_instance_of(ApplicationController).to recieve(:current).and_return(admin)
    visit vendors_path
    click_link "Peter's Produce"

    expect(current_path).to eq vendor_admin_items_path(vendor)
    expect(page).to have_content("Peter's Produce")
    expect(page).to have_content("Squash")
    expect(page).to have_link("Squash")
    expect(page).to have_content("It's good for you")
    expect(page).to have_content("$2.00")
    expect(page).to have_link("Edit")
    expect(page).to have_button("Create Item")
    expect(page).to have_button("Delete Item")
  end

  context 'with admin logged in, admin can create items' do
    allow_any_instance_of(ApplicationController).to recieve(:current).and_return(admin)
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

  context 'with admin logged in, admin can edit items' do
    allow_any_instance_of(ApplicationController).to recieve(:current).and_return(admin)
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

  context 'with admin logged in, admin can edit items' do
    allow_any_instance_of(ApplicationController).to recieve(:current).and_return(admin)
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
