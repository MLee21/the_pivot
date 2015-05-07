require 'rails_helper'

RSpec.feature "login" do

  let!(:user)  { create(:user) }
  let!(:admin) { create(:admin) }

  scenario "default user logs in" do
    visit root_path

    click_button "Login"

    fill_in "session[email]", with: "example@email.com"
    fill_in "session[password]", with: "p"

    click_button "Submit"

    expect(page).to have_content("Howdy, kulio!")
    expect(page).to have_select("category_id")
    expect(page).to have_link("View Dogs in Cart")
    expect(page).to have_button("Logout")
  end

  scenario "admin user logs in" do
    visit root_path

    click_button "Login"

    fill_in "session[email]", with: "admin@email.com"
    fill_in "session[password]", with: "p"

    click_button "Submit"

    expect(page).to have_content("Howdy, admin!")
    expect(page).to have_select("option_option_type")
    expect(page).to have_button("Logout")

    expect(page).to_not have_link("View Dogs in Cart")
    expect(page).to_not have_select("category_id")
  end

end
