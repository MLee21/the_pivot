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
    # create_items
    # create_orders
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
  end

  def create_users
    @sam = BusinessAdministrator.create!(full_name: "Sam Sam", password: "password", email: "sam@turing.io", vendor: @vendor)
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

  def create_items
    Item.create!(title: "Turing Assessment Week", description: "A miserable dog seasoned with the tears of students", price: 200, image: File.open('app/assets/images/sad_dog.jpg'))

    puts "Items created"
  end

  def create_orders
    Order.create!(user_id: @rachel.id, status_id: @ordered.id, order_date: DateTime.new(2015, 4, 5), items: [Item.find(16), Item.find(9), Item.find(16), Item.find(16), Item.find(2), Item.find(2)])
    Order.create!(user_id: @rachel.id, status_id: @paid.id, order_date: DateTime.new(2015, 4, 6), items: [Item.find(2), Item.find(4)])
    Order.create!(user_id: @jeff.id, status_id: @ordered.id, order_date: DateTime.new(2015, 4, 7), items: [Item.find(5)])
    Order.create!(user_id: @jeff.id, status_id: @paid.id, order_date: DateTime.new(2015, 4, 8), items: [Item.find(4)])
    Order.create!(user_id: @jeff.id, status_id: @completed.id, order_date: DateTime.new(2015, 4, 8), items: [Item.find(14), Item.find(13)])
    Order.create!(user_id: @jorge.id, status_id: @completed.id, order_date: DateTime.new(2015, 4, 9), items: [Item.find(1)])
    Order.create!(user_id: @jorge.id, status_id: @ordered.id, order_date: DateTime.new(2015, 4, 10), items: [Item.find(11)])
    Order.create!(user_id: @jorge.id, status_id: @cancelled.id, order_date: DateTime.new(2015, 5, 5), items: [Item.find(19), Item.find(9)])
    Order.create!(user_id: @jeff.id, status_id: @cancelled.id, order_date: DateTime.new(2015, 5, 6), items: [Item.find(18)])
    Order.create!(user_id: @rachel.id, status_id: @paid.id, order_date: DateTime.new(2015, 5, 7), items: [Item.find(19)])
    puts "Orders created"
  end

  def create_categories
    # Category.create!(name: "Vegetables", items: [Item.find(20), Item.find(13), Item.find(16)])
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
