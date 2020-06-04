class CreateSalesPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_prices do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
