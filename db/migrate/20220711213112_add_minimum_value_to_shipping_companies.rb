class AddMinimumValueToShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :minimum_value, :integer, default: 0
  end
end
