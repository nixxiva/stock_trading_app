class Admin::DashboardController < ApplicationController
  layout 'admin'
  
  def index
    @all_users = User.where(is_admin: false)
    @pending_users = User.where(is_admin: false, is_approved: false)
  end

  def show
  end

end
