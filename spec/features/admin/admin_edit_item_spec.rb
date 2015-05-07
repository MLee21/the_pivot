require 'rails_helper'

RSpec.describe 'admin item edit' do

  let!(:admin) { create(:admin) }
  let!(:item)  { create(:item) }

  context 'with admin logged in' do

    it 'allows admin to edit items' do
      item.title = 'super dog'
      item.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_items_path

      expect(page).to have_content('super dog')

      click_link_or_button 'Edit'

      fill_in 'Title', with: 'spicy dog'
      fill_in 'Description', with: 'hot damn'
      click_link_or_button 'Update'

      expect(page).not_to have_content('super dog')
      expect(page).to have_content('spicy dog')
      expect(page).to have_content('$2.00')
    end
  end

end
