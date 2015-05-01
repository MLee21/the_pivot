require 'rails_helper'

RSpec.feature 'admin can view a single order' do
  let!(:admin) { create(:admin) }
  let!(:status) { create(:status) }

  context 'with admin logged in' do
    scenario 'displays a single order' do
      user = User.create(full_name: "Rachel Warbelow",
                         email: "rachelw@gmail.com",
                         display_name: "rachelw",
                         password: 'password',
                         role: 0)
      order = user.orders.create!(order_date: "2015-04-29 21:07:32",
                                  status_id: status.id)
      item = order.items.create!(title: "the dog that barks back",
                                 description: "yummy",
                                 price: 100)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_order_path(order)

      expect(page).to have_content("Date 2015-04-29")
      expect(page).to have_content("Time 21:07")
      expect(page).to have_content("Purchaser")
      expect(page).to have_content("Rachel Warbelow")
      expect(page).to have_content("rachelw@gmail.com")
      expect(page).to have_content("rachelw@gmail.com")
      expect(page).to have_selector(:link_or_button, "the dog that barks back")
      expect(page).to have_content("Count: 1")
      expect(page).to have_content("Price: $1.00")
      expect(page).to have_content("Sub total: $1.00")
      expect(page).to have_content("Total $1.00")
      expect(page).to have_content("Status ordered")
    end

    xscenario 'displays a single order with multiple items' do
      user = User.create(full_name: "Rachel Warbelow",
                         email: "rachelw@gmail.com",
                         display_name: "rachelw",
                         password: 'password',
                         role: 0)
      order = user.orders.create!(order_date: "2015-04-29 21:07:32",
                                  status_id: status.id)
      order.items.create!(title: "the dog that barks back",
                                 description: "yummy",
                                 price: 100)
      order.items.create(title: "the classic",
                                 description: "old school",
                                 price: 100)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_order_path(order)

      expect(page).to have_content("Date 2015-04-29")
      expect(page).to have_content("Time 21:07")
      expect(page).to have_content("Purchaser")
      expect(page).to have_content("Rachel Warbelow")
      expect(page).to have_content("rachelw@gmail.com")
      expect(page).to have_content("rachelw@gmail.com")
      expect(page).to have_selector(:link_or_button, "the dog that barks back")
      expect(page).to have_selector(:link_or_button, "the classic")
      expect(page).to have_content("Count: 2")
      expect(page).to have_content("Price: $1.00")
      expect(page).to have_content("Sub total: $2.00")
      expect(page).to have_content("Total $2.00")
      expect(page).to have_content("Status ordered")
    end
  end
end
