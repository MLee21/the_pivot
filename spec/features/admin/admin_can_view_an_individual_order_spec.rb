require 'rails_helper'

RSpec.feature 'admin can view a single order' do

  let!(:admin)  { create(:admin) }
  let!(:user)   { create(:user) }
  let!(:status) { create(:status) }
  let!(:order)  { create(:order) }
  let!(:item)   { create(:item) }

  before(:each) do
    order.status_id = status.id
    order.user_id   = user.id
    order.items << item
    order.save
  end

  context 'with admin logged in' do

    xscenario 'displays a single order' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit order_path(order)

      expect(page).to have_content("Date 2015-10-04")
      expect(page).to have_content("Time 00:00")
      expect(page).to have_content("Purchaser")
      expect(page).to have_content("MyName")
      expect(page).to have_content("example@email.com")
      expect(page).to have_link("Hotdog")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("1")
      expect(page).to have_content("Price")
      expect(page).to have_content("$2.00")
      expect(page).to have_content("Sub Total")
      expect(page).to have_content("Total")
      expect(page).to have_content("Status")
      expect(page).to have_content("ordered")
    end

    xscenario 'displays a single order with multiple items' do
      order.items << item
      order.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit order_path(order)

      expect(page).to have_content("Date 2015-10-04")
      expect(page).to have_content("Time 00:00")
      expect(page).to have_content("Purchaser")
      expect(page).to have_content("MyName")
      expect(page).to have_content("example@email.com")
      expect(page).to have_link("Hotdog")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("2")
      expect(page).to have_content("Price")
      expect(page).to have_content("$2.00")
      expect(page).to have_content("Sub Total")
      expect(page).to have_content("$4.00")
      expect(page).to have_content("Total")
      expect(page).to have_content("Status")
      expect(page).to have_content("ordered")
    end
  end
end
