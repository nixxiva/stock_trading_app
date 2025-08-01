class Trader::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock_data
  before_action :trader_check
  layout "trader"
  def show; end

  def index
    redirect_to trader_user_path(current_user)  
  end
end 
