require 'rails_helper'

RSpec.feature "logout" do 

  scenario "default user logs out" do
    user = RegisteredUser.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")
    visit root_path

    click_link "Login"

    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"

    click_button "Submit"

    expect(page).to have_content("Howdy, Tracy!")
  
    click_button "Logout"

    expect(page).to have_content("Howdy, Guest!")  
  end
end