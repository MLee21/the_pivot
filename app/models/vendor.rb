class Vendor < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  before_validation :generate_slug


  def generate_slug
    self.slug = name.parameterize
  end
end
