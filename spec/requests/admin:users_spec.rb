require 'rails_helper'

RSpec.describe "Admin:users", type: :request do
  let(:admin_user) { create(:admin_user) } # This ensures it's both an admin and approved
  let(:user) { create(:user, email: "user_#{SecureRandom.hex(8)}@example.com") }

  before do
    sign_in admin_user  # Sign in the admin user before each test
  end

  describe "GET /admin/users" do
    it "returns the admin user index page" do
      get admin_users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /admin/users/:id" do
    it "retuns the admin user show page" do
      get admin_user_path(admin_user)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /admin/users" do
    it "creates a new user" do
      post admin_users_path, params: { user: { email: "examplelang@email.com", password: "a123456" , password_confirmation: "a123456" }}
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /admin/users/:id/edit" do
    it "lets edit an existing user" do
      get edit_admin_user_path(admin_user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /admin/users/:id" do
    it "updates the existing user" do
    updated_attributes = { email: "new_email@example.com", password: "newpassword123", password_confirmation: "newpassword123" }
      patch admin_user_path(admin_user), params: { user: updated_attributes }
      admin_user.reload
      expect(admin_user.email).to eq("new_email@example.com")
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE /admin/users/:id" do
    it "deletes the existing user" do
      expect(User.exists?(user.id)).to be true
      delete admin_user_path(user)
      expect(User.exists?(user.id)).to be false
      expect(response).to have_http_status(302)
    end
  end
end