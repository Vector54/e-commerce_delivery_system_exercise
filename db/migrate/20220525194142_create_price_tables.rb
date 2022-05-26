class CreatePriceTables < ActiveRecord::Migration[7.0]
  def change
    create_table :price_tables do |t|
      t.references :shipping_company, null: false, foreign_key: true
      t.integer :minimum_value

      t.timestamps
    end
  end
end
