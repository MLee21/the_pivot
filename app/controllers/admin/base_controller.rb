class Admin::BaseController < ApplicationController

  before_action :ensure_admin_user

  Item.unscoped.where(discontinue: true)
end