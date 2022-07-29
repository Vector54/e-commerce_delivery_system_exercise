# frozen_string_literal: true

class AddVehicleToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :vehicle
  end
end
