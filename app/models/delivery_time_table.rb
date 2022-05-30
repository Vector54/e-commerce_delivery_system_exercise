class DeliveryTimeTable < ApplicationRecord
  belongs_to :shipping_company
  has_many :delivery_time_lines
end
