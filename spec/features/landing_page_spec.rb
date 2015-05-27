require 'rails_helper'

feature "a guest user visits the home page" do 
  scenario "successfully" do 
    visit root_path
    expect(page).to have_content("Cowboy Kyle's Farmers Market")
    within 'nav' do 
      expect(page).to have_link("Home")
      expect(page).to have_link("Login/Register")
      expect(page).to have_link("Vendors")
      expect(page).to have_link("View Items in Basket")
    end
    expect(page).to have_content("Farmers Corner")
  end
end
