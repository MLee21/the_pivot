require 'rails_helper'

  feature "a registered user views list of vendors" do
    let!(:user) {RegisteredUser.create(full_name:"Tracy", email: "tslice@gmail.com", password:"password", password_confirmation: "password")}
    let!(:vendor) {create(:vendor)}

    scenario "successfully" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "tslice@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Submit"
      expect(current_path).to eq(vendors_path)
      expect(page).to have_content("Howdy, Tracy!")
      within 'nav' do
        expect(page).to have_link("Vendors")
      end
    end
end
