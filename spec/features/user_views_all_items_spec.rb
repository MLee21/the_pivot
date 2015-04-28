require 'rails_helper'

feature "user views items index" do 

  let(:user) { create(:user) }

  scenario "user sees all items" do 
    create(:item)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit items_path

    expect(page).to have_content("hotdog_1")
  end

end 