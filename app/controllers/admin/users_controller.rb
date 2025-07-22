class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @all_users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_root_path, notice: "User successfully created"
    else
      render :new, status: :unprocessable_entity, alert: "Failed creating user, try again"
    end
  end

  def show
  end

  def edit
  end

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
end
