require 'rails_helper'

RSpec.feature 'admin category create' do
  let!(:admin) { create(:admin) }

  context 'with admin logged in' do
    scenario 'allows admin to create a category' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_category_path

      fill_in "Name", with: "dank"
      click_link_or_button "Create category"

      expect(page).to have_content("List of Categories:")
      expect(page).to have_content("Category successfully created")
      expect(page).to have_content("dank")
      expect(page).to have_content("Howdy, admin")
    end

    scenario 'does not allow admin to create a category without a name' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_category_path

      click_link_or_button "Create category"

      expect(page).to have_content("Name can't be blank")
    end
  end
end