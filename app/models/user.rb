class User < ActiveRecord::Base
  validates :full_name, :role, presence: true
  validates :email, uniqueness: true, presence: true, email_format: { message: 'is not looking good'}

  has_many :item_categories
  has_many :items, through: :item_categories

  has_secure_password
end
