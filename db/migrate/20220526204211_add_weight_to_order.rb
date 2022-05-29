class AddWeightToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :weight, :integer
  end
end
