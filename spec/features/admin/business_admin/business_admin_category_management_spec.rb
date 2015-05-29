require "rails_helper"

  feature "a business admin" do

    before(:each) do
      @vendor = Vendor.create(name: "Peter's Produce")
      @vendor2 = Vendor.create(name: "Nicholas Cage's Candies")
      @business_admin = BusinessAdministrator.create(full_name:"Gary Johnson", email: "Whatevs@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor)
      @business_admin2 = BusinessAdministrator.create(full_name:"Marilyn Manson", email: "Bloodbath@gmail.com", password:"password", password_confirmation: "password", vendor: @vendor2)
      category = Category.create(name: "Organic")
      category2 = Category.create(name: "Juicy")
      category3 = Category.create(name: "Gluten-Free")
      item = @vendor.items.create({title: "Squash", description: "It's good for you", price: 200})
      item2 = @vendor.items.create({title: "Melon", description: "It's good for you", price: 300})
      item3 = @vendor.items.create({title: "Strawberries", description: "It's good for you", price: 400})
      item4 = @vendor2.items.create({title: "OMG gummies", description: "Ah", price: 200})
      item.categories << category
      item2.categories << category2
      item3.categories << category3
      item4.categories << category3
    end

    scenario "logs in and can see all categories associated with their store" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "Whatevs@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Submit"
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Peter's Produce")
      expect(page).to have_link("View Orders")
      expect(page).to have_link("Current Items")
      expect(page).to have_link("Manage Administrators")
      expect(page).to have_link("Edit Vendor Profile")
      expect(page).to have_link("Categories")
    end

    scenario "clicks to see all categories associated with their store" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "Whatevs@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Submit"
      click_link "Categories"
      expect(page).to have_content("Organic")
      expect(page).to have_content("Juicy")
      expect(page).to have_content("Gluten-Free")
    end

    scenario "clicks on a category and sees the items associated with that category for their store only" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "Whatevs@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Submit"
      click_link "Categories"
      expect(page).to have_content("Gluten-Free")
      click_link "Gluten-Free"
      expect(page).to have_content("Strawberries")
      expect(page).to have_content("$4.00")
      expect(page).to_not have_content("OMG gummies")
    end

    xscenario "edits a category" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "Whatevs@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Submit"
      click_link "Categories"
      click_link "Edit"
      within('ul.orders_table li:nth-child(1)') do
        click_link('Edit')
      end
      fill_in "Name", with: "Non-GMO"
      click_button "Update"
      expect(page).to_not have_content("Gluten-Free")
      expect(page).to have_content("Non-GMO")
    end

    scenario "creates a new category" do
      visit root_path
      click_link "Login/Register"
      fill_in "session[email]", with: "Whatevs@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Submit"
      click_link "Categories"
      click_button "Create category"
      fill_in "Name", with: "Terribly Good for You"
      click_button "Create category"
      expect(current_path).to eq(admin_categories_path)
      expect(page).to have_content("Terribly Good for You")
    end
  end
