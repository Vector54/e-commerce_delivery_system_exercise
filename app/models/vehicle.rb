class Vehicle < ApplicationRecord
  belongs_to :shipping_company
  validates :plate, :brand_model, :weight_capacity, presence: true
end
