class AddShippingCompanyToPriceLines < ActiveRecord::Migration[7.0]
  def change
    add_reference :price_lines, :shipping_company, null: false, foreign_key: true
  end
end
