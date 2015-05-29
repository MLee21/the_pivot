# require "rails_helper"

# # As business admin, when someone buys something on my store, I receive an email notification

# RSpec.describe OrderMailer, type: :mailer do
  
#   before(:each) do 
#     @vendor = Vendor.create(name: "Peter's Produce")
#     @business_admin = BusinessAdministrator.create(full_name:"MyName", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor_id: @vendor.id)
#     @user = RegisteredUser.create(full_name:"Bobo", password: "yolo", password_confirmation: "yolo", email:"bobo@gmail.com")
#     @mail = OrderMailer.order_notification_to_admin(@business_admin)
#   end

#   context "a business owner should receive an email" do
#     it "when a user purchases items from their store" do 
#       expect(@mail.subject).to eq("New Order")
#       expect(@mail.to).to eq([@business_admin.email])
#       expect(mail.from).to eq(['noreply@company.com'])
#     end
#   end 
# end
