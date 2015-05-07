require 'rails_helper'

RSpec.feature "logout" do 

  let!(:user) { create(:user) }

  scenario "default user logs out" do
    visit root_path

    click_button "Login"

    fill_in "session[email]", with: "example@email.com"
    fill_in "session[password]", with: "p"

    click_button "Submit"

    expect(page).to have_content("Howdy, kulio!")
  
    click_button "Logout"

    expect(page).to have_content("Howdy, Guest!")  
  end
end