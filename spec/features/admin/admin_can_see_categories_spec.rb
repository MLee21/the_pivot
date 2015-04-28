require 'rails_helper'

RSpec.feature 'admin category view' do
  let!(:admin) { create(:admin) }

  context 'with admin logged in' do
    scenario 'displays the categories' do
      Category.create(name: 'delicious')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit root_path

      select "Categories", from: "option[option_type]"

      expect(page).to have_content('delicious')
    end
  end
end
