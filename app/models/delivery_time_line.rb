class DeliveryTimeLine < ApplicationRecord
  belongs_to :delivery_time_table
  validates :init_distance, :final_distance, :delivery_time, presence: true
end
