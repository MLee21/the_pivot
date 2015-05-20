require 'rails_helper'

feature "a guest user visits the home page" do 
  let!(:user) {create(:user)}
  scenario "successfully" do 
    visit root_path
    expect(page).to have_content("Cowboy Kyle's Farmers Market")
    within 'nav' do 
      expect(page).to have_link("Home")
      expect(page).to have_link("Login/Register")
      expect(page).to have_link("Vendors")
      expect(page).to have_link("View Items in Cart")
    end
    expect(page).to have_content("Farmers Corner")
    expect(page).to have_content("Peter's Produce")
    expect(page).to have_content("Tom's Seafood")
    expect(page).to have_content("Pretzel Hut")
  end
end
