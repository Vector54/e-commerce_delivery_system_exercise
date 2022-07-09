class AddIndexToShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    add_index :shipping_companies, :cnpj, unique: true
  end
end
