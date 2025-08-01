require 'rails_helper'

RSpec.describe "Trader::Users", type: :request do
  let(:t_user) { FactoryBot.create(:t_user)} 

  before do
    sign_in t_user
  end

  describe "GET /trader/users" do
    it "succesfully gets the trader path" do
      get trader_user_path(t_user.id)
      expect(response).to have_http_status(200)
    end

  end
end
