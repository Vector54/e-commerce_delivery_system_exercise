class RemoveDeliveryTimeTablesFromDeliveryTimeLines < ActiveRecord::Migration[7.0]
  def change
    remove_reference :delivery_time_lines, :delivery_time_table, null: false, foreign_key: true
  end
end
