require "rails_helper"

feature "a guest customer views list of vendors" do 
  let!(:user) {create(:user)}
  let!(:vendor) {create(:vendor)}

  xscenario "successfully" do 
    visit root_path
    click_link("Vendors")
    expect(current_path).to eq(vendors_path)  
  end

  xscenario "and selects one vendor" do 
    item = {title: "Squash", description: "It's healthy", price: 100}
    vendor.items.create(item)
    visit root_path
    click_link("Vendors")
    expect(current_path).to eq(vendors_path)  
    expect(page).to have_link("Peter's Produce")
    click_link "Peter's Produce"
    expect(current_path).to eq(vendor_items_path(:vendor))
    expect(page).to have_content("Squash")
  end 

  xscenario "and selects a different vendor" do 
    different_vendor = Vendor.create(name: "John's Ciders")
    item = {title: "Sour apple", description: "John's sour apple recipe", price: 300}
    different_vendor.items.create(item)
    visit root_path
    click_link("Vendors")
    expect(current_path).to eq(vendors_path)
    expect(page).to have_link("Peter's Produce")
    expect(page).to have_link("John's Ciders")
    click_link("John's Ciders")
    expect(current_path).to eq(vendor_items_path(different_vendor))
  end

end



