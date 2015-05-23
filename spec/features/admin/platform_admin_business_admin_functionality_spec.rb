require "rails_helper"

feature "a platform administrator can manage" do 

  before(:each) do 
    @platform_admin = User.create(full_name:"Brenda Smith", email: "bobsRcool@gmail.com", password:"password", password_confirmation: "password", role: 2)
    @business_admin = User.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", role: 1)
    @second_admin = User.create(full_name:"Sally Jones", email: "imag@gmail.com", password:"password", password_confirmation: "password", role: 1)
    @user = User.create(full_name:"Jiminy Cricket", email: "datruth@gmail.com", password:"password", password_confirmation: "password", role: 0)
    allow_any_instance_of(ApplicationController).to receive(@user).and_return(user)
    click_button "Create Business"
    fill_in "Vendor Name", with: "Protein Power"
    fill_in "Vendor Description", with: "Powdered Bugs are good for you"
    #based off of email, method will find by email and match it as the first, and the first email is the first administrator for store
    fill_in "Vendor Administrator", with: "datruth@gmail.com"
    click_button "Create Business"
    expect(page).to have_content("You will receive an email about the status of your business application")
    @vendor = Vendor.create(name: "Aimee's Fruit Stand")
    item = {title: "Fruit Basket", description: "An assortment of berries", price: 500}
    item2 = {title: "Melons", description: "It's a melon", price: 200}
    @vendor.items.create(item)
    @vendor.items.create(item2)
    visit root_path
    click_button "Login/Register"
    fill_in "session[email]", with: "bobsRcool@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Submit"
  end

  scenario "a business' items" do 
    allow_any_instance_of(ApplicationController).to receive(@platform_admin).and_return(platform_admin)
    expect(current_path).to eq(platform_admin_dashboard_path)
    click_button "Aimee's Fruit Stand"
    # maybe same path as what a business admin would see?
    expect(current_path).to eq(platform_admin_vendor_path)
    click_button "Fruit Basket"
    expect(page).to have_content("An assortment of berries")
    expect(page).to have_content("$5.00")
    within ".vendor_item" do 
      click_link "Update Item"
    end
    fill_in "price", with: 600
    click_button "Update"
    expect(page).to_not have_content("$5.00")
    expect(page).to have_content("6.00")
  end

  scenario "and update a business' information" do 
    allow_any_instance_of(ApplicationController).to receive(@platform_admin).and_return(platform_admin)
    click_button "Aimee's Fruit Stand"
    within ".vendor_info" do 
      click_link "Update Vendor Information"
    end
    fill_in "Name", with: "Aimee's Fruits"
    click_button "Update"
    expect(page).to_not have_content("Aimee's Fruit Stand")
    expect(page).to have_content("Aimee's Fruits")
  end

  scenario "and update a business' administrators" do 
    allow_any_instance_of(ApplicationController).to receive(@platform_admin).and_return(platform_admin)
    click_button "Aimee's Fruit Stand"
    within ".vendor_admins" do 
      click_link "Sally Jones"
    end
    select "Remove", from: "business_admin[status]"
    # probably have some method that will update the role attribute to false if a business admin is removed from the role
    expect(@second_admin.business_admin?).to_not be_true
  end

  scenario "and approve the creation of a new business" do 
    click_button "Pending Businesses"
    click_button "Protein Power"
    click_button "Approve"
    expect(page).to have_content("Email approval has been sent")
  end

  scenario "and decline the creation of a new business" do 
    click_button "Pending Businesses"
    click_button "Protein Power"
    click_button "Decline"
    expect(page).to have_content("Email disapproval has been sent")
  end

  scenario "and take a business offline" do 
    click_button "Aimee's Fruit Stand"
    click_link "Suspend Vendor"
    expect(page).to have_content("Are you sure you want to suspend this vendor?")
    click_button "Yes"
    expect(page).to have_content("Vendor suspended")
  end

  scenario "and take a business online" do 
    click_button "Aimee's Fruit Stand"
    click_link "De-Activate Vendor"
    expect(page).to have_content("Are you sure you want to suspend this vendor?")
    click_button "Yes"
    visit platform_admin_dashboard_path
    click_button "Aimee's Fruit Stand"
    click_link "Activate Vendor"
    expect(page).to have_content("Vendor has been activated")
  end
end