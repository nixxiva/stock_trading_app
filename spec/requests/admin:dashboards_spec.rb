require 'rails_helper'

RSpec.describe "Admin::Dashboard", type: :request do
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/dashboards" do
    it "returns dashboard" do
      get admin_dashboard_index_path
      expect(response).to have_http_status(200)
    end
  end
end
