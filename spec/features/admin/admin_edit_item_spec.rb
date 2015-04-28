require 'rails_helper'

RSpec.describe 'admin item edit' do

  let(:admin) do
    User.create(full_name: 'Sara Meek',
                email: 'sara@gmail.com',
                role: 1)
              end

  context 'with admin logged in' do
    it 'allows admin to edit items' do
      Item.create(title: 'chili dog', description: 'yummy', price: 100)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_items_path
      expect(page).to have_content('chili dog')
      expect(page).to have_content('yummy')

      click_link_or_button 'Edit'
      fill_in 'Title', with: 'spicy dog'
      fill_in 'Description', with: 'hot damn'
      click_link_or_button 'Update'

      expect(page).not_to have_content('chili dog')
      expect(page).to have_content('spicy dog')
      expect(page).to have_content('hot damn')
      expect(page).to have_content('100')
    end
  end

end
