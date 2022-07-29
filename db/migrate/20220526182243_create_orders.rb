# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.references :admin, null: false, foreign_key: true
      t.date :date
      t.string :code
      t.references :shipping_company, null: false, foreign_key: true
      t.integer :distance
      t.string :pickup_adress
      t.string :product_code
      t.integer :width
      t.integer :height
      t.integer :depth
      t.string :delivery_adress
      t.string :cpf

      t.timestamps
    end
  end
end
