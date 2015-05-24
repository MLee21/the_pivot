require 'rails_helper'

RSpec.feature 'business admin CRUD functionality for secondary admins' do

  # let!(:admin2) { create(:admin2) }
  # let!(:admin)  { create(:admin) }
  # let!(:vendor) { create(:vendor) }
  # let!(:item)   { create(:item) }
  # let!(:status) { create(:status) }
  # let!(:vendor) { create(:vendor) }
  # admin.vendor_id = vendor.id
  # admin2.vendor_id = vendor.id


  scenario 'with secondary admin logged in, admin can not view all admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit vendor_admins_path(vendor: vendor.slug)
    expect(page).to have_content "The page you were looking for doesn't exists (404)"
  end


  scenario 'with secondary admin logged in, admin can not create admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_vendor_admin_path(vendor: vendor.slug)
    expect(page).to have_content "The page you were looking for doesn't exists (404)"
  end

  scenario 'with secondary admin logged in, admin can update their own account' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit vendor_admin_path(vendor: vendor.slug)

    expect(page).to have_content "Welcome, MyName!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "MyName"
    expect(page).to have_link "MyName"
    expect(page).to have_content "admin@email.com"
    expect(page).to have_content "admin"

    click_button "Update Admin"

    expect(current_path).to eq edit_vendor_admin_path(vendor: vendor.slug)

    fill_in "Full Name", with: "UpdatedAdmin"
    fill_in "Display Name", with: "Update"
    fill_in "Email", with: "update@admin.com"
### Password and roll should be set to a default password and 1 performed in the controller before save
    click_button "Submit"

    expect(current_path).to eq vendor_admin_path(vendor: vendor.slug)
    expect(page).to have_content "Welcome, Admin!"
    expect(page).to have_content "Peter's Produce"
    expect(page).to have_content "Business Administrators:"
    expect(page).to have_content "UpdatedAdmin"
    expect(page).to have_link "UpdatedAdmin"
    expect(page).to have_content "Update"
    expect(page).to have_content "update@email.com"
  end

  scenario 'with secondary admin logged in, admin can update their own account' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
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
