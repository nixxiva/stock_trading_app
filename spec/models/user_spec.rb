require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do 
    it 'fails to create a User without an email' do
      user = User.new(name: "sam")
      expect(user).not_to be_valid
    end
    it 'should have a default balance of 10000' do 
      user = User.new
      expect(user.usd_balance).to eq(10000)
    end
  end
end
