class User < ActiveRecord::Base
  validates :full_name, presence: true
  validates :email, uniqueness: true, presence: true, email_format: { message: 'is not looking good'}
  validates :display_name, length: { in: 2..32 }, allow_blank: true

  has_many :item_categories
  has_many :items, through: :item_categories

  has_secure_password

  enum role: ["default", "admin"]

  def admin?
    role == "admin"
  end

  def display?
    display_name && display_name != ""
  end

  def name_to_display
    display_name.presence || full_name
  end
end
