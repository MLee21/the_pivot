require 'rails_helper'

RSpec.feature 'user can view thier orders' do

  let!(:user) { create(:user) }
  let!(:order) { create(:order) }
  let!(:status) { create(:status) }

  before(:each) do
    order.status_id = status.id
    user.orders << order
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
    expect(page).to have_content "1"
    expect(page).to have_content "2015-10-04"
    expect(page).to have_content "2"
    expect(page).to have_content "ordered"
  end
end
