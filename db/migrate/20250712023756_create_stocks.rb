class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
