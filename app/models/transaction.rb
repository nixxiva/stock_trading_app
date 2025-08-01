class Transaction < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true
  validates :is_buy, inclusion: [true, false]
  validates :quantity, presence: true, comparison: {  other_than: 0 }
  validates :price, presence: true
  validates :total_price, presence: true

   def self.ransackable_attributes(auth_object = nil)
    ["symbol", "is_buy", "created_at", "quantity", "price", "total_price"]
  end
end
