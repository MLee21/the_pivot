require 'rails_helper'

RSpec.feature "login" do

  let!(:user) { create(:user) }

  scenario "default user logs in" do
    visit root_path

    click_button "Login"

    fill_in "session[email]", with: "example@email.com"
    fill_in "session[password]", with: "p"

    click_button "Submit"

    expect(page).to have_content("Howdy, kulio!")
  end
end
