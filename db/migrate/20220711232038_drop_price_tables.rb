class DropPriceTables < ActiveRecord::Migration[7.0]
  def up
    drop_table :price_tables
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
