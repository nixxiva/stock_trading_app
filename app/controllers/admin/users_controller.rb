class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :set_user, only: [:show, :edit, :update, :destroy, :approve]
  before_action :authorize_admin!
  
  def index
    @all_users = User.where(is_admin: false)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_approved = true
    if @user.save
      redirect_to admin_users_path, notice: "User successfully created"
    else
      render :new, status: :unprocessable_entity, alert: "Failed creating user, try again"
    end
  end

  def show; end

  def edit; end

  def update
    @user.assign_attributes(user_params)
    @user.skip_reconfirmation!
    if @user.save
      redirect_to admin_user_path(@user), notice: "User updated successfully"
    else 
      render :edit, status: :unprocessable_entity, alert: "Unable to update user"
    end
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted"
  end

  def pending_approvals
    @pending_users = User.where(is_approved: false).where.not(confirmed_at: nil)
  end
  
  def approve  
    @user.update(is_approved: true)
    redirect_to pending_approvals_admin_users_path, notice: "User approved and can now log in"
  end
  
  private
  
  def user_params
    permitted = params.require(:user).permit(:email, :password, :password_confirmation)
    if permitted[:password].blank?
      permitted.delete(:password)
      permitted.delete(:password_confirmation)
    end
    permitted
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin!
    unless current_user.present? && current_user.is_admin? && current_user.is_approved?
    redirect_to root_path, alert: "You are not authorized to access this administrative area."
    end
  end
end
