require 'rails_helper'

RSpec.feature 'admin category edit' do
  let!(:admin) { create(:admin) }

  context 'with admin logged in' do
    scenario 'allows admin to update categories' do
      category = Category.create(name: 'spicy')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_categories_path

      expect(page).to have_content('spicy')

      click_link_or_button 'Edit'
      fill_in 'Name', with: 'firedog'
      click_link_or_button 'Update'

      expect(page).to have_content('firedog')
      expect(page).not_to have_content('spicy')
    end
  end
end