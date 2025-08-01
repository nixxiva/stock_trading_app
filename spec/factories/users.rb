FactoryBot.define do

  factory :user do
  	email { "user@example.com" }
  	password { "password" }
  	password_confirmation { "password" }
  	confirmed_at { Time.now }
	end

  factory :t_user , parent: :user do
    is_admin {false}
    is_approved {true}
	end

	factory :admin_user, parent: :user do
  	is_admin { true }
  	is_approved { true }
	end
end
