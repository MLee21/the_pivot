require 'rails_helper'

RSpec.feature 'admin item creation' do

  let!(:user)     { create(:user) }
  let!(:admin)    { create(:admin) }
  let!(:item)     { create(:item) }
  let!(:status)   { create(:status) }
  let!(:category) { create(:category) }

  context 'with admin logged in' do
    
    xscenario 'displays the items' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_items_path

      expect(page).to have_content("Cowboy Kyle's Hotdog Ranch")
      expect(page).to have_content("Hotdog")
    end

    xscenario 'allows creation of items' do
      category.name = "All Dogs"
      category.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
     
      visit new_admin_item_path

      fill_in 'Title', with: 'pizza dog'
      fill_in 'Description', with: "those aren't chickenpox on that dog"
      fill_in 'Price', with: 1
      click_link_or_button 'Create dog'

      expect(page).to have_content("Cowboy Kyle's Hotdog Ranch")
      expect(page).to have_content('pizza dog')
      expect(page).to have_content('$1.00')
    end
  end

  context 'with default user logged in' do
    
    xscenario 'does not allow default user to create items' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit new_admin_item_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  
    xscenario 'displays a 404' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_items_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

end
