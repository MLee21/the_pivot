require 'rails_helper'

RSpec.describe User, type: :model do 
  let(:user) { User.new(full_name: "Jason", password: "p", role: 0, email: "user@example.com")}
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
end