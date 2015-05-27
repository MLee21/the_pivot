require 'rails_helper'

feature "user views item show page" do 
  let(:user) { create(:user) }

  xscenario "user sees item page" do 
    create(:item, title: "Spicy Hotdog", description: "super description")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit items_path
    click_on "Spicy Hotdog"

    expect(page).to have_content("super description")
  end

  xscenario "unauthorized user sees item page" do 
    create(:item, title: "Spicy Hotdog", description: "super description")
    visit items_path
    click_on "Spicy Hotdog"

    expect(page).to have_content("super description")
  end
end