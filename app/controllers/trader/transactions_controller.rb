class Trader::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock_data
  before_action :trader_check
  layout "trader"

  def new
    if !$stock_data.has_key?(params[:inpsymbol])
      redirect_to trader_user_path(current_user), notice: "Redirected, no such stock ticker in database"
    else
      @symbol = params[:inpsymbol]
    end
    set_stock()
    @transaction = current_user.transactions.build
  end

  def create
    #initial checker variables
    error_msg = "Error"
    is_valid = true
    redirecting = false
    @transaction = current_user.transactions.new(transaction_params) 
    #validity checkers
    if transaction_params.keys.size < 3
      is_valid = false
      error_msg = "missing parameters"
    end
    if !$stock_data.has_key?(@transaction.symbol)
      is_valid = false
      error_msg = "Redirected, no such stock ticker in database"
      redirect_to trader_user_path(current_user), notice: "Redirected, no such stock ticker in database"
      redirecting = true
    end
    if @transaction.quantity == nil
      @transaction.quantity = 0
      is_valid = false
      error_msg = "Quantity can't be 0" 
    end
    #sets price and total price from the user input
    if is_valid
      @transaction.price = $stock_data[@transaction.symbol][:price]
      @transaction.total_price = (@transaction.price * @transaction.quantity)
    end
    @symbol = @transaction.symbol
    set_stock() 
    
    
    #checks if the user has enough balance
    if is_valid && @transaction.is_buy
      if @transaction.total_price > current_user.usd_balance
        is_valid = false
        error_msg = "Not enough balance"
      end
    #checks if user has enough stocks to sell
    else
      if @transaction.quantity > @stock.balance
        is_valid = false
        error_msg = "You do not enough of that stock to sell"
      end
    end

    p @transaction
    p is_valid
    if is_valid == true && @transaction.save
      #adds and deducts balances
      if @transaction.is_buy
        @stock.balance = @stock.balance += @transaction.quantity
        current_user.usd_balance = current_user.usd_balance - @transaction.total_price
      else 
        @stock.balance = @stock.balance -= @transaction.quantity
        current_user.usd_balance = current_user.usd_balance + @transaction.total_price
      end
      @stock.save
      current_user.save
      redirect_to trader_user_stocks_path(current_user), notice: "Successful transaction"
    else
      #errors and redirecting
      puts @transaction.errors.full_messages
      flash.now[:alert] = error_msg
      if redirecting == false
        render :new, status: :unprocessable_entity 
      end
    end
  end

  def index
    @transactions = current_user.transactions
  end

  private

  def set_stock()
    if @stock = (current_user.stocks.find_by(symbol: @symbol))
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
