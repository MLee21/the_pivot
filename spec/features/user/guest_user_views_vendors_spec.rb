require "rails_helper"

# As a guest customer, 
# I should be able to see a link for the list of the different business
#  and click on either "Vendors" or "Order Online"
#   on the landing page which will redirect me to the vendors index

feature "a guest customer views list of vendors" do 
  let!(:user) {create(:user)}
  let!(:vendor) {create(:vendor)}
  let!(:item) {create(:item)}

  xscenario "successfully" do 
    visit root_path
    click_link("Vendors")
    expect(current_path).to eq(vendors_path)  
  end
#   and I will be able to click on an individual business
#  and be directed to that business' page. 
#  Once I am on that business' page, I should be able to see that business' items.
  xscenario "and selects one vendor" do 
    visit root_path
    click_link("Vendors")
    expect(current_path).to eq(vendors_path)  
    expect(page).to have_link("Peter's Produce")
    click_link "Peter's Produce"
    expect(current_path).to eq(vendor_items_path)
    expect(page).to have_content("Squash")
  end 

  xscenario "and selects a different vendor" do 
    different_vendor = Vendor.create(name: "John's Ciders")
  end

end



