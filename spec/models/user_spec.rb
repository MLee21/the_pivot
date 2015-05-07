require 'rails_helper'

RSpec.describe User, type: :model do 
  let!(:user)   { create(:user) }
  let!(:admin)  { create(:admin) }
  let!(:status) { create(:status) }
  let!(:order)  { create(:order) }
  
  it "is a valid user" do 
    expect(user).to be_valid
  end

  it "is invalid without a full name" do 
    user.full_name = nil
    expect(user).not_to be_valid
  end

  it "is valid without a display name" do 
    expect(user).to be_valid
  end

  it "is valid with a display name" do 
    user.display_name = "Fred"
    expect(user).to be_valid
  end

  it "is invalid if display name is one character" do
    user.display_name = "F"
    expect(user).not_to be_valid
  end

  it "is invalid if display name is 33 characters" do
    user.display_name = "FreddyFreddyFreddyFreddyFreddyFre"
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do 
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is invalid with an invalid email" do 
    user.email = "email_address"
    expect(user).not_to be_valid
  end

  it "can be a default user or admin" do
    expect(user.admin?).to eq(false)
    expect(admin.admin?).to eq(true)
  end

  it "returns correct display name" do
    expect(user.name_to_display).to eq("kulio")
    user.display_name = nil
    expect(user.name_to_display).to eq("MyName")
  end

  it "returns orders by status" do
    order.status_id = status.id
    order.user_id = user.id
    order.save
    expect(user.orders_by_status).to eq({"cancelled" => 0,
                                         "completed" => 0,
                                         "ordered" => 1,
                                         "paid" => 0})
  end

end