require 'rails_helper'

RSpec.feature "user sees all items in cart" do

  let!(:user) {User.create!(full_name: "Jorge Tellez", email: "demo_jorge@jumpstartlab.com", password: "password")}
  let!(:category) {Category.create!(name: "All")}
  let!(:status) {Status.create!(name: "ordered")}
  let!(:item) {Item.create!(title: "Super Dog", description: "a hot dog", price: 200, categories: [category])}

  scenario "guest user sees one item in cart" do
    visit items_path

    click_link_or_button "Add to Cart"
    click_link_or_button "View Dogs in Cart (1)"

    expect(page).to have_content "Super Dog"
    expect(page).to have_content "1"
    expect(page).to have_content "$2.00"
  end

  scenario "authenticated user checks out" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit items_path
    click_link_or_button "Add to Cart"
    click_link_or_button "View Dogs in Cart (1)"
    expect(page).to have_content "Total: $2.00"
    click_button "Login to buy dogs!"
    fill_in "session[email]", with: "demo_jorge@jumpstartlab.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"

    expect(page).to have_content "Title"
    expect(page).to have_content "Price"
    expect(page).to have_button "Buy them dogs!"
  end
end
