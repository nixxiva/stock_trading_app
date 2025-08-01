class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :set_user, only: [:show, :edit, :update, :destroy, :approve]
  before_action :authorize_admin!
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
    @all_users = User.where(is_admin: false).order(created_at: :desc).page(params[:page]).per(5)
    @total_users = @all_users.total_count
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
    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted"
    else
      redirect_to admin_users_path, alert: "Failed to delete user"
    end
  end

  def pending_approvals
    @pending_users = User.where(is_approved: false).where.not(confirmed_at: nil)
  end
  
  def approve  
    @user.update(is_approved: true)
    UserMailer.with(user: @user).approval_email.deliver_now
    redirect_to pending_approvals_admin_users_path, notice: "User approved and can now log in"
  end

  private
  
  def user_params
    permitted = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    if permitted[:password].blank?
      permitted.delete(:password)
      permitted.delete(:password_confirmation)
    end
    permitted
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_not_found
    redirect_to admin_users_path, alert: "User not found"
  rescue ActiveRecord::RecordNotFound
    render 'errors/not_found', status: :not_found 
  rescue StandardError => e
    redirect_to admin_users_path, alert: "An error occurred while trying to find the user."
  end
end
