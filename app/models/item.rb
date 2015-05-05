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

  def format_price(form_value)
    self.price = form_value.to_f * 100
    self.save
  end

end
