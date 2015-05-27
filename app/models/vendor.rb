class Vendor < ActiveRecord::Base
  has_many :items
  has_many :business_administrators
  validates :name, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :slug, presence: true, uniqueness: true
  before_validation :generate_slug


  def generate_slug
    self.slug = name.parameterize
  end
end
