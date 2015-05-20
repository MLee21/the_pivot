require "rails_helper"

feature "a registered user can edit profile" do
  let!(:user) User.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")
  let!(:vendor) {create(:vendor)}
  let!(:item) {create(:item)}

  senario "registered customer can login and edit profile with correct information" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with "tslice@gmail.com"
    fill_in "session[password]", with "password"
    click_link("Profile")
    click_link("Update Info")
    fill_in "user[full_name]", with "Ru Paul"
    fill_in "user[display_name]", with "onehotbitch"
    fill_in "user[user_email]", with "thatbitchisonfire@gmail.com"
    fill_in "user[password]", with "dragordie"
    fill_in "user[password_confirmation]", with "dragordie"
    click_link("Update Account")
    expect(current_path).to eq root_path
  end

  senario "registered customer can't edit profile without a full name" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with "tslice@gmail.com"
    fill_in "session[password]", with "password"
    click_link("Profile")
    click_link("Update Info")
    fill_in "user[full_name]", with ""
    click_link("Update Account")
    expect(page).to have_content("Invalid updates")
  end

  senario "registered customer can't edit profile without a email" do
    # ? allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # visit login page
    visit root_path
    # click login
    click_link("Login")
    # fill in login information
    fill_in "session[email]", with "tslice@gmail.com"
    fill_in "session[password]", with "password"
    click_link("Profile")
    click_link("Update Info")
    fill_in "user[user_email]", with " "
    click_link("Update Account")
    expect(page).to have_content("Invalid updates")
  end
end
