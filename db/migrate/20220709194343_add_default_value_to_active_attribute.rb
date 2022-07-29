class AddDefaultValueToActiveAttribute < ActiveRecord::Migration[7.0]
  def up
    change_column_default :shipping_companies, :active, true
  end

  def down
    change_column_default :shipping_companies, :active, nil
  end
end
