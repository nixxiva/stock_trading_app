require 'rails_helper'

RSpec.describe "Admin::Transactions", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:transaction) { create(:transaction) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/transactions" do
    it "returns a successful response" do
      get admin_transactions_path
      expect(response).to have_http_status(200)
    end
  end
end
