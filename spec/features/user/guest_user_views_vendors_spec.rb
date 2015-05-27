require "rails_helper"

feature "a guest customer views list of vendors" do
  let!(:vendor) {create(:vendor)}

  scenario "successfully" do
    visit root_path
    within ".main-nav" do
      click_link("Vendors")
    end
      expect(current_path).to eq(vendors_path)
  end

  scenario "and selects one vendor" do
    item = {title: "Squash", description: "It's healthy", price: 100}
    vendor.items.create(item)
    visit root_path
    within ".main-nav" do
      click_link("Vendors")
    end
    expect(current_path).to eq(vendors_path)
    expect(page).to have_link("Peter's Produce")
    click_link "Peter's Produce"
    expect(current_path).to eq(vendor_items_path(vendor: vendor.slug))
    expect(page).to have_content("Squash")
  end

  scenario "and selects a different vendor" do
    different_vendor = Vendor.create(name: "John's Ciders")
    item = {title: "Sour apple", description: "John's sour apple recipe", price: 300}
    different_vendor.items.create(item)
    visit root_path
    within ".main-nav" do
      click_link("Vendors")
    end
    expect(current_path).to eq(vendors_path)
    expect(page).to have_link("Peter's Produce")
    expect(page).to have_link("John's Ciders")
    click_link("John's Ciders")
    expect(current_path).to eq(vendor_items_path(vendor: different_vendor.slug))
  end

end


