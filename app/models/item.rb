class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true

  has_many :item_categories
  has_many :categories, through: :item_categories

  has_attached_file :image
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]
end
