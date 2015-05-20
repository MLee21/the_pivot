require 'rails_helper'

RSpec.describe Vendor, type: :model do

  before(:each) do 
    @vendor = Vendor.create(name: "Peter's Produce")
    @vendor2 = Vendor.create(name: "Tom's Seafood")
  end

  it "has valid attributes" do 
    expect(@vendor.name).to eq("Peter's Produce")
    expect(@vendor.slug).to eq("peter-s-produce")
  end

  it "has a unique name" do 
    expect(@vendor.name).to eq("Peter's Produce")
    imposter_vendor = @vendor.dup
    expect(imposter_vendor).to_not be_valid
  end

  it "has a unique slug" do
    expect(@vendor.slug).to eq("peter-s-produce")
    imposter_vendor = @vendor.dup
    expect(imposter_vendor).to_not be_valid
  end

  it "has to have a name" do
    @vendor.name = " " 
    expect(@vendor).to_not be_valid
  end

  it "has to have a slug" do
    @vendor.name = ""
    expect(@vendor).to_not be_valid
  end
end
