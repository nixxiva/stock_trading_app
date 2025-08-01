require 'rails_helper'

RSpec.describe "Admin:dashboards", type: :request do
  describe "GET /admin:dashboards" do
    it "works! (now write some real specs)" do
      get admin:dashboards_path
      expect(response).to have_http_status(200)
    end
  end
end
