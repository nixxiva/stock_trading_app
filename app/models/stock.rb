class Stock < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true
  validates :balance, presence: true
end
