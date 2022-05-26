class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :brand_model
      t.date :year
      t.integer :weight_capacity

      t.timestamps
    end
  end
end
