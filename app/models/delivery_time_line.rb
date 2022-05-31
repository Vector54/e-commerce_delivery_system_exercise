class DeliveryTimeLine < ApplicationRecord
  belongs_to :delivery_time_table
  validates :init_distance, :final_distance, :delivery_time, presence: true
  validate :minimum_bigger_than_maximum, :cannot_intersect_with_other_ranges

  private

    def minimum_bigger_than_maximum
      unless self.init_distance.nil? || self.final_distance.nil?
        if self.init_distance > self.final_distance
          errors.add(:init_distance, 'mínimo não pode ser maior que máximo.')
        end
      end
    end

    def cannot_intersect_with_other_ranges
      delivery_time_lines = DeliveryTimeLine.where(delivery_time_table: self.delivery_time_table)
      if delivery_time_lines.any?
        delivery_time_lines.each do |dtl|
          if (self.init_distance > dtl.init_distance && self.init_distance < dtl.final_distance) ||
            (self.final_distance > dtl.init_distance && self.final_distance < dtl.final_distance)
            errors.add(:init_distance, 'não pode intersectar com outras linhas.')
            errors.add(:final_distance, 'não pode intersectar com outras linhas.')
          end
        end
      end
    end
end
