require 'rails_helper'

RSpec.describe 'admin item creation' do

  let(:admin) do
    User.create(full_name: 'John Smith',
                email: 'john@gmail.com',
                role: 1)
              end
  let(:default_user) do
    User.create(full_name: 'Adam Burns',
                email: 'adam@gmail.com',
                role: 0)
              end

  it 'displays the items' do
    Item.create(title: 'chili dog', description: 'yummy', price: 100)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_items_path
    expect(page).to have_content("Cowboy Kyle's Hotdog Ranch")
    expect(page).to have_content("chili dog")
  end

  context 'with admin logged in' do
    it 'allows creation of items' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_item_path

      fill_in 'Title', with: 'pizza dog'
      fill_in 'Description', with: "those aren't chickenpox on that dog"
      fill_in 'Price', with: 100
      click_link_or_button 'Create dog'

      expect(page).to have_content("Cowboy Kyle's Hotdog Ranch")
      expect(page).to have_content('pizza dog')
      expect(page).to have_content("those aren't chickenpox on that dog")
    end
  end

  context 'with default user logged in' do
    it 'does not allow creation of items without valid attributes' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_item_path

      fill_in 'Description', with: "those aren't chickenpox on that dog"
      fill_in 'Price', with: 100
      click_link_or_button 'Create dog'

      expect(page).to have_content("Title can't be blank")
    end
  end

  context 'with default user logged in' do
    xit 'displays a 404' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)
      visit admin_items_path

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

end
