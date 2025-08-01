class Trader::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :trader_check
  layout "trader"

  def index
    @stocks = current_user.stocks
  end
end
