class ChangeDefaultBalance < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :usd_balance, from: nil, to: 10000
  end
end
