class PriceLine < ApplicationRecord
  belongs_to :price_table
  validates :minimum_volume, :maximum_volume, :minimum_weight, :maximum_weight, :value, presence: true
end
