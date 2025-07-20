class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

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
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User updated"
    else 
      render :edit, status: :unprocessable_entity, alert: "Unable to update user"
    end
  end

  def destroy
  end

  private

  def user_params
    if @user.new_record? 
      params.require(:user).permit(:email, :password, :password_confirmation)
    else
      params.require(:user).permit(:email, :password, :password_confirmation).reject { |key, value| value.blank? }
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
