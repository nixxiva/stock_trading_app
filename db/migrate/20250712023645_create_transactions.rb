class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :symbol
      t.boolean :is_buy
      t.integer :quantity
      t.float :price
      t.float :total_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
