require 'rails_helper'

  feature "a registered user views list of vendors" do
    let!(:user) {create(:user)}
    let!(:vendor) {create(:vendor)}

    scenario "successfully" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "example@email.com"
      fill_in "session[password]", with: "p"
      click_button "Submit"
      expect(current_path).to eq root_path
      expect(page).to have_content("Howdy, kulio!")
      within 'nav' do
        expect(page).to have_link("Vendors")
      end
    end
end
