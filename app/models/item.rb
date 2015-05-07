class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true

  validates :title, uniqueness: true

  validates :price, numericality: { greater_than: 0 }

  has_many :item_categories
  has_many :categories, through: :item_categories

  has_attached_file :image, default_url: "default_dog.jpg"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]

  default_scope { where(discontinue: false) }

  include ContentReport

  def discontinued?
    discontinue
  end

  def format_price(form_price_value)
    self.price = form_price_value.to_f * 100
    self.save
  end

  def add_all_category
    category_all = Category.find_by(name: "All Dogs")
    self.categories << category_all unless self.categories.include?(category_all)
  end

  def category_list
    self.categories.map { |category| category.name }
  end

  def adjust_information(form_price_value)
    self.format_price(form_price_value)
    self.add_all_category 
    self.save
  end

end
