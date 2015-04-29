class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true

  has_many :item_categories
  has_many :categories, through: :item_categories

  has_attached_file :image, default_url: "happy_hot_dog.jpg"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]

  def price_formatted
    "#{sprintf( "$%.02f" , (price.to_f/100))}"
  end

end
