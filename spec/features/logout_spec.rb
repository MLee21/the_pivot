require 'rails_helper'

RSpec.feature "logout" do 

  let!(:user) { User.create(full_name: "Kyle",
                            display_name: "K-dog",
                            role: 1,
                            email: "kdog@gmail.com",
                            password: "p",
                            password_confirmation: "p")}

  scenario "default user logs out" do
    visit root_path

    click_button "Login"

    fill_in "session[email]", with: "kdog@gmail.com"
    fill_in "session[password]", with: "p"

    click_button "Submit"

    expect(page).to have_content("Howdy, K-dog!")
  
    click_button "Logout"

    expect(page).to have_content("Howdy, Guest!")  
  end
end