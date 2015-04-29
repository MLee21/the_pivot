require 'rails_helper'

RSpec.feature "user adds items to cart" do

  let!(:user) {User.create(full_name: "DJ", email: "poopin@gmail.com", password: "p")}

  let!(:category) {Category.create(name: "All")}

  let!(:item) {Item.create(title: "Super Dog", description: "a hot dog", price: 200, categories: [category])}

  scenario "as a guest user from the items index" do
    visit items_path

    expect(page).to have_content("Super Dog")
    click_link_or_button "Add to Cart"
    expect(page).to have_content("Buy Dogs (1)")

    fill_in "order[quantity]", with: "3"

    click_link_or_button "Add to Cart"
    expect(page).to have_content("Buy Dogs (4)")
  end

  scenario "as a logged in user from the items index" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit items_path

    expect(page).to have_content("Howdy, DJ")    
    expect(page).to have_content("Super Dog")

    click_link_or_button "Add to Cart"

    expect(page).to have_content("Buy Dogs (1)")

    fill_in "order[quantity]", with: "3"

    click_link_or_button "Add to Cart"

    expect(page).to have_content("Buy Dogs (4)")
  end

  scenario "as a logged in user from the item path" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit item_path(item)

    expect(page).to have_content("Super Dog")

    fill_in "order[quantity]", with: "3"
    click_link_or_button "Add to Cart"

    expect(page).to have_content("Buy Dogs (3)")
  end


end