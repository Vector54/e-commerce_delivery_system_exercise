class CreateDeliveryTimeLines < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_time_lines do |t|
      t.integer :init_distance
      t.integer :final_distance
      t.integer :delivery_time
      t.references :delivery_time_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
