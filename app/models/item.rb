class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true

  has_many :item_categories
  has_many :categories, through: :item_categories
end
