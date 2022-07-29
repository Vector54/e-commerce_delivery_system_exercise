# frozen_string_literal: true

class CreateUpdateLines < ActiveRecord::Migration[7.0]
  def change
    create_table :update_lines do |t|
      t.string :coordinates
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
