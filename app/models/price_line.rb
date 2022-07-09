# frozen_string_literal: true

class PriceLine < ApplicationRecord
  belongs_to :price_table
  validates :minimum_volume, :maximum_volume, :minimum_weight, :maximum_weight, :value, presence: true
  validate :minimum_volume_bigger_than_maximum_volume, :data_intersection, :minimum_weight_bigger_than_maximum_weight

  private

  def minimum_volume_bigger_than_maximum_volume
    if !(minimum_volume.nil? || maximum_volume.nil?) && (minimum_volume > maximum_volume)
      errors.add(:minimum_volume, 'não pode ser maior do que o máximo.')
    end
  end

  def minimum_weight_bigger_than_maximum_weight
    if !(minimum_weight.nil? || maximum_weight.nil?) && (minimum_weight > maximum_weight)
      errors.add(:minimum_weight, 'não pode ser maior do que o máximo.')
    end
  end

  def data_intersection
    if PriceLine.where(price_table: price_table).any?
      price_line_array = PriceLine.where(price_table: price_table)

      price_line_array.each do |pl|
        next unless ((minimum_volume > pl.minimum_volume && minimum_volume < pl.maximum_volume) ||
          (maximum_volume > pl.minimum_volume && maximum_volume < pl.maximum_volume)) &&
                    ((minimum_weight > pl.minimum_weight && minimum_weight < pl.maximum_weight) ||
                    (maximum_weight > pl.minimum_weight && maximum_weight < pl.maximum_weight))

        errors.add(:minimum_volume, 'não pode intersectar com outras linhas enquanto o peso tambem o faz.')
        errors.add(:minimum_weight, 'não pode intersectar com outras linhas enquanto o volume tambem o faz.')
      end
    end
  end
end
