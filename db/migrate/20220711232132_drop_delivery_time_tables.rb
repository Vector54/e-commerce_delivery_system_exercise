class DropDeliveryTimeTables < ActiveRecord::Migration[7.0]
  def up
    drop_table :delivery_time_tables
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
