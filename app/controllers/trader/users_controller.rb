class Trader::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock_data
  def show
  end
end 
