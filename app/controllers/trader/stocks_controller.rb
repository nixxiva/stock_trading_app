class Trader::StocksController < ApplicationController
  before_action :authenticate_user!
  layout "trader"

  def index
    @stocks = current_user.stocks
  end
end
