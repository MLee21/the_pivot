require 'rails_helper'

RSpec.describe "a status" do

  let!(:status) { create(:status) }

  it "is valid" do
    expect(status).to be_valid
  end

  it "is invalid without a name" do
    status.name = nil
    expect(status).to_not be_valid
  end

  it "can find the id of paid status" do
    status.name = "paid"
    status.save
    expect(Status.paid_id).to eq(status.id)
  end

end