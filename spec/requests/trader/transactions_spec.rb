require 'rails_helper'

RSpec.describe "Trader::Transactions", type: :request do
  let(:t_user) { FactoryBot.create(:t_user)} 
  let!(:newstock) { t_user.stocks.create(symbol: "TEST2", balance: 2)}

  before do
    sign_in t_user
    $stock_data = {}
    $stock_data["TEST"] = {name: "The testing stock", price: 123}
    $stock_data["TEST2"] = {name: "Next testing stock", price: 321}
  end

  describe "gets the trader transaction index path" do
    it "succesfully gets the tx index path" do
      get trader_user_transactions_path(t_user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "goes to the new transaction path" do
    it "gets the new tx path" do
      get new_trader_user_transaction_path(t_user, inpsymbol: "TEST")
      expect(response).to have_http_status(200)
    end
    it "gets redirected if the input symbol does not exist" do
      get new_trader_user_transaction_path(t_user, inpsymbol: "NONE")
      expect(response).to have_http_status(302)
    end
  end

  describe "submits a new tx request" do
    it "makes a successful buy tx" do
      post trader_user_transactions_path(t_user), params: {
        transaction: {
          symbol: "TEST",
          quantity: 1,
          is_buy: true,
        }
      }   
      expect(response).to have_http_status(302)
      expect(Transaction.count).to eq(1)
      expect(t_user.usd_balance).to eq(10000 - 123)
      expect(Stock.count).to eq(2)
    end 
    it "makes a successful sell tx" do
      post trader_user_transactions_path(t_user), params: {
        transaction: {
          symbol: "TEST2",
          quantity: 1,
          is_buy: false,
        }
      } 
      expect(response).to have_http_status(302)
      expect(Transaction.count).to eq(1)
      expect(t_user.usd_balance).to eq(10000 + 321)
    end 
    it "fails when quantity is 0" do
      post trader_user_transactions_path(t_user), params: {
        transaction: {
          symbol: "TEST2",
          quantity: 0,
          is_buy: false,
        }
      } 
      expect(Transaction.count).to eq(0)
    end
    it "catches fails with a wrong symbol" do
      post trader_user_transactions_path(t_user), params: {
        transaction: {
          symbol: "TEST9",
          quantity: 1, 
          is_buy: true,
        }
      } 
      expect(Transaction.count).to eq(0)
      expect(response).to have_http_status(302)
    end
    it "catches a missing field symbol and re-renders" do
      post trader_user_transactions_path(t_user), params: {
        transaction: {
          symbol: "TEST2",
          is_buy: true,
        }
      } 
      expect(Transaction.count).to eq(0)
      expect(response).to have_http_status(422)
    end
  end
end