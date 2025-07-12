class Transaction < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true
  validates :is_buy, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :total_price, presence: true
end
