require 'rails_helper'

RSpec.feature 'admin can view all orders' do
  let!(:admin)  { create(:admin) }
  let!(:user)   { create(:user) }
  let!(:status) { create(:status) }
  context 'with admin logged in' do
    scenario 'displays multiple orders' do
      # user = User.create(full_name: "Rachel Warbelow",
      #                    email: "rachelw@gmail.com",
      #                    display_name: "rachelw",
      #                    password: "password",
      #                    role: 0)
      order = user.orders.create!(order_date: "2015-04-29 21:07:32",
                          status_id: status.id)
      order.items.create!(title: "doggy biscut",
                          description: "golden",
                          price: 200)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_orders_path

      expect(page).to have_content("Total Orders by Status")
      expect(page).to have_content("ordered")
      expect(page).to have_content("1")
      expect(page).to have_content("Orders:")
      expect(page).to have_link("2015-04-29 21:07")
      expect(page).to have_content("List of Orders by Status")
      expect(page).to have_content("ordered:")
      expect(page).to have_content("paid:")
      expect(page).to have_content("cancelled:")
      expect(page).to have_content("completed:")
      expect(page).to have_link("status")
    end
  end
end