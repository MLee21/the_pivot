# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

class Seed

  attr_reader :rachel, :jeff, :jorge, :josh, :ordered, :paid, :cancelled, :completed

  def self.start
    new.generate
  end

  def generate
    create_vendors
    create_vendor_items
    create_users
    create_statuses
    create_user_orders
    create_categories
  end

  def create_vendors
    @vendor = Vendor.create!(name:"Peter's Produce")
    19.times do |vendor|
      vendor = Vendor.create(name: Faker::Company.name)
    end
  end

  def create_vendor_items
    item = {title: "Squash", description: "It's good for you", price: 200, image: open('app/assets/images/squash.jpg')}
    @vendor.items.create!(item)
    count = Item.all.count
    range = (1..19).to_a

    Vendor.all.each do |vendor|
      10.times do 
        vendor.items.create(title: Faker::Name.title, description: Faker::Lorem.sentence, price: Faker::Commerce.price, image: File.open("app/assets/images/#{range.sample}.jpg"))
      end
    end
  end

  def create_user_orders
    10.times do 
      @josh.orders.create(status_id: @ordered.id, order_date: Time.now, vendor_id: Vendor.all.sample)
    end

    @josh.orders.each do |order|
      items = Item.take(10)
        items.each do |item|
          order.items << item
        end
    end
  end
 
  def create_users
    @sam = BusinessAdministrator.create!(full_name: "Sam Sam", password: "password", email: "sam@turing.io", vendor_id: @vendor.id)
    @josh = RegisteredUser.create!(full_name: "Josh Cheek", password: "password", display_name: "josh", email: "josh@turing.io")
    98.times do |user|
      user = RegisteredUser.create!(full_name: Faker::Name.name, password: "password", email: Faker::Internet.email)
    end
    puts "#{User.all.map(&:full_name).join(", ")} created."
  end

  def create_statuses
    @ordered = Status.create!(name: "ordered")
    @paid = Status.create!(name: "paid")
    @cancelled = Status.create!(name: "cancelled")
    @completed = Status.create!(name: "completed")

    puts "Statuses created"
  end

  def create_categories
    Category.create!(name: "Vegetables")
    Category.create!(name: "Fried Goodness")
    Category.create!(name: "Fruits")
    Category.create!(name: "Chocolate")
    Category.create!(name: "Organic")
    Category.create!(name: "Dairy")
    Category.create!(name: "Gluten-Free")
    Category.create!(name: "Homemade Spirits")
    Category.create!(name: "Baked Goods")
    Category.create!(name: "Meats")
    puts "Categories Created"
  end

end

Seed.start
