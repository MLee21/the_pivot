require 'rails_helper'

RSpec.feature 'user can view thier orders' do

  let!(:user) { create(:user) }
  let!(:order) { create(:order) }
  let!(:order2) { create(:order) }
  let!(:status) { create(:status) }
  let!(:status2) { create(:status) }

  before(:each) do
    order.status_id = status.id
    status2.name = "completed"
    status2.save
    order2.status_id = status2.id
    user.orders << order
    user.orders << order2
  end

  scenario "when authenticated user is logged in" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    expect(page).to have_content "Howdy, kulio!"
    click_link "Orders"

    expect(page).to have_content "Orders by Status"
    expect(page).to have_content "Ordered:"
    expect(page).to have_content "Paid:"
    expect(page).to have_content "Cancelled:"
    expect(page).to have_content "Complete:"
    expect(page).to have_content "Orders Details (all orders)"
    expect(page).to have_content "Order #"
    expect(page).to have_content "Date"
    expect(page).to have_content "# of Items"
    expect(page).to have_content "Status"
    expect(page).to have_content "2"
    select "completed", from: "status[status_id]"
    expect(page).to have_content "completed"
    ## "845" is the order-id of the order with status ordered
    expect(page).not_to have_content "845"
  end
end
