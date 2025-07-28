class Trader::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock_data

  def new
    if $stock_data[params[:inpsymbol]] == nil
      redirect_back_or_to trader_user_path(current_user), notice: "Redirected, no such stock ticker in database"
    else
      @symbol = params[:inpsymbol]
    end
    if @stock = (current_user.stocks.find_by(symbol: @symbol))
    else
      @stock = current_user.stocks.new(symbol: @symbol, balance: 0)
    end
  end

  def create
  end

  def index
  end

  private

  def transaction_params
    params.require(:transaction).permit(:symbol, :is_buy, :quantity, :price, :total_price)
  end

  def stock_params
    params.require(:stock).permit(:symbol, :balance)
  end
end
