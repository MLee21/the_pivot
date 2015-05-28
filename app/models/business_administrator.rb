class BusinessAdministrator < User
  belongs_to :vendor
  validates :vendor_id, presence: true

  def first_administrator?(current_user)
    first_admin = User.where(vendor_id: current_user.vendor.id).first
    current_user == first_admin
  end
end