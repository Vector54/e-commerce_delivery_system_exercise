# frozen_string_literal: true

class CreateDeliveryTimeTables < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_time_tables do |t|
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
