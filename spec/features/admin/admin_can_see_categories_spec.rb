require 'rails_helper'

RSpec.feature 'admin category view' do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  context 'with admin logged in' do
    scenario 'displays the categories' do
      Category.create(name: 'delicious')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit root_path

      select "Categories", from: "option_option_type"

      expect(page).to have_content('delicious')
      expect(page).to have_content('Howdy, admin')
    end
  end

  context 'with user logged in' do
    scenario 'does not display admin options' do
      Category.create(name: 'delicious')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit root_path

      expect(page).to have_content("delicious")
      expect(page).not_to have_content("Howdy, admin")
      expect(page).not_to have_content("Admin options:")
    end
  end
end
