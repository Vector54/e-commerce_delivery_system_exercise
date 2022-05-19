class CreateShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_companies do |t|
      t.string :name
      t.string :corporate_name
      t.string :email_domain
      t.string :cnpj
      t.string :billing_adress
      t.boolean :active

      t.timestamps
    end
  end
end
