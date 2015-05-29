require "rails_helper"

feature "a registered user can edit profile" do
  let!(:user) {RegisteredUser.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")}
  let!(:vendor) {create(:vendor)}
  let!(:item) {create(:item)}

  scenario "registered customer can login and edit profile with correct information" do
    visit root_path
    click_link("Login/Register")
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    click_link("Profile")
    click_button("Update Info")
    fill_in "registered_user[full_name]", with: "Ru Paul"
    fill_in "registered_user[display_name]", with: "onehotbitch"
    fill_in "registered_user[email]", with: "thatbitchisonfire@gmail.com"
    fill_in "registered_user[password]", with: "dragordie"
    fill_in "registered_user[password_confirmation]", with: "dragordie"
    click_button("Update Account")
    expect(current_path).to eq root_path
  end

  scenario "registered customer can't edit profile without a full name" do
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    click_link("Profile")
    click_button("Update Info")
    fill_in "registered_user[full_name]", with: ""
    click_button("Update Account")
    expect(page).to have_content("Invalid updates")
  end

  scenario "registered customer can't edit profile without a email" do
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    click_link("Profile")
    click_button("Update Info")
    fill_in "registered_user[email]", with: " "
    click_button("Update Account")
    expect(page).to have_content("Invalid updates")
  end
end
