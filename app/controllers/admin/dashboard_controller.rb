class Admin::DashboardController < ApplicationController
  layout 'admin'

  def index
    @all_users = User.all
    @pending_users = User.where(is_approved: false).where(is_admin: false)
    @user = current_user
  end
end
