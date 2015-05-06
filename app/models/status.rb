class Status < ActiveRecord::Base
  validates :name, presence: true

  has_many :orders

  def self.paid_id
    find_by(name: "paid").id
  end

end
