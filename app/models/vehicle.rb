class Vehicle < ApplicationRecord
  belongs_to :shipping_company
  has_one :order
  validates :plate, :brand_model, :weight_capacity, presence: true
end
