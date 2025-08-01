FactoryBot.define do

  factory :user do
	name { "Test User" }
  	email { "user_#{SecureRandom.hex(8)}@example.com" }
  	password { "password" }
  	password_confirmation { "password" }
  	confirmed_at { Time.now }
	end

	factory :admin_user, parent: :user do
    is_admin { true }
    is_approved { true }
  end
end
