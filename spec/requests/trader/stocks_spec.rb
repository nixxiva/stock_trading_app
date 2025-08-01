require 'rails_helper'

RSpec.describe "Trader::Stocks", type: :request do
  let(:t_user) { FactoryBot.create(:t_user)} 

  before do
    sign_in t_user
  end

  describe "get trader stocks index" do
    it "succesfully gets the stock index" do
      get trader_user_stocks_path(t_user.id)
      expect(response).to have_http_status(200)
    end
  end
end
