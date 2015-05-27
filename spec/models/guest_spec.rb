require 'rails_helper'

RSpec.describe "a guest user" do

  let!(:guest) { Guest.new }

  xit "is not an admin" do
    expect(guest.admin?).to eq(false)
  end

  xit "has a Guest display name" do
    expect(guest.name_to_display).to eq("Guest")
  end

end