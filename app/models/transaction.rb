class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :symbol, presence: true
  validates :is_buy, inclusion: [true, false]
  validates :quantity, presence: true, comparison: { other_than: nil, other_than: 0 }
  validates :price, presence: true
  validates :total_price, presence: true
end
