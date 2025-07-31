class Trader::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock_data
  layout "trader"
  def show; end

  def index
    redirect_to trader_user_path(current_user)  
  end
end 
