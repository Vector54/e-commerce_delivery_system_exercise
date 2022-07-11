class RemovePriceTablesFromPriceLines < ActiveRecord::Migration[7.0]
  def change
    remove_reference :price_lines, :price_table, null: false, foreign_key: true
  end
end
