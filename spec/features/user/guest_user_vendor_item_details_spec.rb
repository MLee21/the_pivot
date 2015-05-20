require "rails_helper"

feature "a guest user clicks on an item for a specific vendor" do

  before(:each) do
    @vendor = Vendor.create(name: "Peter's Produce")
    @vendor2 = Vendor.create(name: "Joe's Spirits")
    @item = {title: "Squash", description: "It's healthy", price: 100}
    @item2 = {title: "Shoe Polish", description: "Will stop cancer cells", price: 400}
    @vendor.items.create(@item)
    @vendor2.items.create(@item2)
    visit root_path
    within ".main-nav" do
      click_link("Vendors")
    end
    click_link "Peter's Produce"
    click_link "Squash"
  end

  scenario "and sees the details successfully" do
    expect(page).to have_content("Squash")
    expect(page).to have_content("It's healthy")
    expect(page).to have_content("$1.00")
  end

  scenario "and will not see another vendor's specific item" do
    expect(page).to_not have_content("Shoe Polish")
    expect(page).to_not have_content("Will stop cancer cells")
    expect(page).to_not have_content("$4.00")
  end

  scenario "successfully adds one item to their cart" do
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (1)"
    expect(current_path).to eq(cart_index_path)
    expect(page).to have_content("Squash")
    expect(page).to have_content("$1.00")
    expect(page).to have_content(1)
  end

  scenario "successfully adds two items from different vendors" do
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (1)"

    visit vendors_path
    click_link "Joe's Spirits"
    click_link "Shoe Polish"
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (2)"

    expect(current_path).to eq(cart_index_path)
    expect(page).to have_content("Squash")
    expect(page).to have_content("Shoe Polish")
    expect(page).to have_content("1.00")
    expect(page).to have_content("4.00")
    expect(page).to have_content("$5.00")
    expect(page).to have_content(2)
  end

  scenario "successfully deletes an item" do
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (1)"
    expect(current_path).to eq(cart_index_path)
    expect(page).to have_content("Squash")

    click_button "Remove"
    expect(page).to_not have_content("Squash")
    expect(page).to_not have_content("$1.00")
    expect(page).to have_content("View Items in Cart (0)")
  end

  scenario "successfully increases an item" do
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (1)"

    expect(page).to have_content("Squash")
    expect(page).to have_content("1")

    first(:button, "+").click
    expect(page).to have_content("Squash")
    expect(page).to have_content("2")
    expect(page).to have_content("$2.00")
  end

  scenario "successfully decreases an item" do
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (1)"
    expect(page).to have_content("Squash")
    expect(page).to have_content("1")

    first(:button, "-").click

    expect(page).to_not have_content("Squash")
    expect(page).to_not have_content("1")
    expect(page).to_not have_content("$1.00")
  end

  scenario "unsuccessfully checks out" do
    click_button "Add to Basket"
    click_link_or_button "View Items in Cart (1)"

    expect(current_path).to eq(cart_index_path)
    expect(page).to have_content("Squash")
    expect(page).to have_content("$1.00")
    expect(page).to have_content(1)

    click_button "Login to Checkout!"
    expect(page).to have_content("No account? create one now!")
  end
end
