class Admin::BaseController < ApplicationController
  
  before_action :ensure_admin_user
end