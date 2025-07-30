class Trader::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock_data

  def new
    if $stock_data[params[:inpsymbol]] == nil
      redirect_to trader_user_path(current_user), notice: "Redirected, no such stock ticker in database"
    else
      @symbol = params[:inpsymbol]
    end
    set_stock()
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = current_user.transactions.new(transaction_params) 
    @transaction.quantity = 0 if @transaction.quantity == nil
    @transaction.price = $stock_data[@transaction.symbol][:price]
    @transaction.total_price = (@transaction.price * @transaction.quantity)
    @symbol = @transaction.symbol
    set_stock()
    if @transaction.save
      if @transaction.is_buy
        @stock.balance = @stock.balance += @transaction.quantity
      else 
        @stock.balance = @stock.balance -= @transaction.quantity
      end
      @stock.save
      redirect_to trader_user_path(current_user), notice: "successful transaction"
    else
      @symbol = @transaction.symbol
      flash.now[:alert] = "error creating post"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @transactions = current_user.transactions
  end

  private
  def set_stock()
    if @stock = (current_user.stocks.find_by(symbol: @symbol))
      p "this is set_stock"
      puts @stock.balance
    else
        @stock = current_user.stocks.new(symbol: @symbol, balance: 0)
        @stock.save
    end
  end

  def transaction_params
    params.require(:transaction).permit(:symbol, :is_buy, :quantity, :price, :total_price)
  end

  def stock_params
    params.require(:stock).permit(:symbol, :balance)
  end
end
