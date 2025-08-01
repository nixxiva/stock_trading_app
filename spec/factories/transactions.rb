FactoryBot.define do

  factory :transaction do
    user
    price { 100.0 }
    quantity { 1 }
    total_price { 200 }
    is_buy { true }
    symbol { "AAPL" }
  end
end