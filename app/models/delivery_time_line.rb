# frozen_string_literal: true

class DeliveryTimeLine < ApplicationRecord
  belongs_to :shipping_company
  validates :init_distance, :final_distance, :delivery_time, presence: true
  validate :minimum_bigger_than_maximum, :cannot_intersect_with_other_ranges

  private

  def minimum_bigger_than_maximum
    if !(init_distance.nil? || final_distance.nil?) && (init_distance > final_distance)
      errors.add(:init_distance, 'mínimo não pode ser maior que máximo.')
    end
  end

  def cannot_intersect_with_other_ranges
    delivery_time_lines = DeliveryTimeLine.where(shipping_company: shipping_company)
    if delivery_time_lines.any?
      delivery_time_lines.each do |dtl|
        next unless (init_distance > dtl.init_distance && init_distance < dtl.final_distance) ||
                    (final_distance > dtl.init_distance && final_distance < dtl.final_distance)

        errors.add(:init_distance, 'não pode intersectar com outras linhas.')
        errors.add(:final_distance, 'não pode intersectar com outras linhas.')
      end
    end
  end
end
