class ChangeYearToString < ActiveRecord::Migration[7.0]
  def change
    change_column :vehicles, :year, :string
  end
end
