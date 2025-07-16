class Admin::UsersController < ApplicationController
  before_action :authenticate_user

  user = current_user   

  def after_sign_in_path_for(user)
    user.is_admin? ? admin_root_path : root_path
  end

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
