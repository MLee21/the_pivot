require 'rails_helper'

RSpec.feature 'admin category view' do
  
  let!(:admin)    { create(:admin) }
  let!(:user)     { create(:user) }
  let!(:category) { create(:category) }

  context 'with admin logged in' do

    xscenario 'displays the categories' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_categories_path

      expect(page).to have_content('spicy')
      expect(page).to have_content('Howdy, admin')
    end
  end

  context 'with user logged in' do
    
    xscenario 'does not display admin options' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_categories_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

end
