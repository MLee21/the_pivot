require 'rails_helper'

RSpec.feature "login" do


  before(:each) do 
    @user = RegisteredUser.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")
    @vendor = Vendor.create(name: "Peter's Produce")
    @business_admin = BusinessAdministrator.create(full_name:"Hans", email: "muscletee@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor)
  end

  scenario "default user logs in" do
    visit root_path

    click_link "Login"

    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"

    expect(page).to have_content("Howdy, Tracy!")
    expect(page).to have_link("View Items in Basket (0)")
    expect(page).to have_button("Logout")
  end

  scenario "admin user logs in" do
    visit root_path

    click_link "Login"

    fill_in "session[email]", with: "muscletee@gmail.com"
    fill_in "session[password]", with: "password"

    click_button "Submit"

    expect(page).to have_content("Howdy, Hans!")
    expect(page).to have_button("Logout")
    expect(page).to_not have_link("View Items in Basket (0)")
  end

end
