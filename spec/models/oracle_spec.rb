require "rails_helper"

describe Oracle do 
  describe "#items" do 
    context "as a business administrator" do 
      it "will return items associated with one vendor" do 
        vendor = Vendor.create(name: "Peter's Produce")
        vendor2 = Vendor.create(name: "Yoda's Yogurts")
        vendor3 = Vendor.create(name: "Neo's Nuggets")
        business_admin = BusinessAdministrator.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor: vendor)
        item1 = vendor.items.create({title: "Squash", description: "It's healthy", price: 100})
        item2 = vendor2.items.create({title: "Strawberry Vanilla", description: "It's healthy", price: 200})
        item3 = vendor3.items.create({title: "Dinosaur Nuggets", description: "Dank", price: 300})
        oracle = Oracle.new(business_admin)
        expect(oracle.items.first).to eq(item1)
      end
    end

     context "as a platform administrator" do 
      it "will return items associated with all vendors" do 
        vendor = Vendor.create(name: "Peter's Produce")
        vendor2 = Vendor.create(name: "Yoda's Yogurts")
        vendor3 = Vendor.create(name: "Neo's Nuggets")
        platform_admin = PlatformAdministrator.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password")
        item1 = vendor.items.create({title: "Squash", description: "It's healthy", price: 100})
        item2 = vendor2.items.create({title: "Strawberry Vanilla", description: "It's healthy", price: 200})
        item3 = vendor3.items.create({title: "Dinosaur Nuggets", description: "Dank", price: 300})
        oracle = Oracle.new(platform_admin)
        expect(oracle.items).to eq([item1, item2, item3])
      end
    end
  end
end


