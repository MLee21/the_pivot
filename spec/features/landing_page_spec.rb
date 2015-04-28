require 'rails_helper'

RSpec.feature "landing page" do

  let!(:category1) { Category.create(name: "Dessert")}
  let!(:user) { User.create(full_name: "Kyle",
                            display_name: "K-dog",
                            role: 1,
                            email: "kdog@gmail.com",
                            password: "p",
                            password_confirmation: "p")}


  scenario "any user visits the homepage" do
    visit root_path

    expect(page).to have_content("Howdy, Guest!")
    expect(page).to have_content("Cowboy Kyle's Hot Dog Ranch")
    expect(page).to have_link("Checkout our dogs!")
    expect(page).to have_button("Login")
    expect(page).to have_content("Buy Dogs") 
    expect(page).to have_select("category_category_id")
  end
end