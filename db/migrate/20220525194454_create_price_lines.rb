# frozen_string_literal: true

class CreatePriceLines < ActiveRecord::Migration[7.0]
  def change
    create_table :price_lines do |t|
      t.integer :minimum_volume
      t.integer :maximum_volume
      t.integer :minimum_weight
      t.integer :maximum_weight
      t.integer :value
      t.references :price_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
