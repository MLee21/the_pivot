class Admin::BaseController < ApplicationController
  before_action :ensure_admin_user

  def ensure_admin_user
    unless current_user.admin?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end