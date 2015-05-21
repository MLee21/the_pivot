require "rails_helper"

feature "a registered user can edit profile" do
  let!(:user) {User.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password", role: 0)}
  let!(:vendor) {create(:vendor)}
  let!(:item) {create(:item)}

  scenario "registered customer can login and edit profile with correct information" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login/Register")
    # fill in login information
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    click_link("Profile")
    # save_and_open_page
    click_button("Update Info")
    fill_in "user[full_name]", with: "Ru Paul"
    fill_in "user[display_name]", with: "onehotbitch"
    fill_in "user[email]", with: "thatbitchisonfire@gmail.com"
    fill_in "user[password]", with: "dragordie"
    fill_in "user[password_confirmation]", with: "dragordie"
    click_button("Update Account")
    expect(current_path).to eq root_path
  end

  scenario "registered customer can't edit profile without a full name" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    click_link("Profile")
    click_button("Update Info")
    fill_in "user[full_name]", with: ""
    click_button("Update Account")
    expect(page).to have_content("Invalid updates")
  end

  scenario "registered customer can't edit profile without a email" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with: "tslice@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
    click_link("Profile")
    click_button("Update Info")
    fill_in "user[email]", with: " "
    click_button("Update Account")
    expect(page).to have_content("Invalid updates")
  end
end
