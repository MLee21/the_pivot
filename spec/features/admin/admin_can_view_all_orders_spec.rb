require 'rails_helper'

RSpec.feature 'admin can view all orders' do
  
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

    scenario 'displays multiple orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_orders_path

      expect(page).to have_content("Orders by Status")
      expect(page).to have_content("ordered")
      expect(page).to have_content("1")
      expect(page).to have_link("#{order.id}")
      expect(page).to have_content("Orders by Status")
      expect(page).to have_content("Orders Details")
      expect(page).to have_content("Ordered:")
      expect(page).to have_content("Paid:")
      expect(page).to have_content("Cancelled:")
      expect(page).to have_content("Complete:")
      expect(page).to have_content("filter:")
    end
  end
end
