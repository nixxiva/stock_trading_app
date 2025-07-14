class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  user = current_user   

  def after_sign_in_path_for(user)
    user.is_admin? ? admin_users_path : root_path
  end
end
