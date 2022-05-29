class PriceLine < ApplicationRecord
  belongs_to :price_table
  validates :minimum_volume, :maximum_volume, :minimum_weight, :maximum_weight, :value, presence: true
  validate :minimum_volume_bigger_than_maximum_volume, :data_intersection, :minimum_weight_bigger_than_maximum_weight

  private

    def minimum_volume_bigger_than_maximum_volume
      unless self.minimum_volume.nil? || self.maximum_volume.nil?
        if self.minimum_volume > self.maximum_volume
          errors.add(:minimum_volume, 'não pode ser maior do que o máximo.')
        end
      end
    end

    def minimum_weight_bigger_than_maximum_weight
      unless self.minimum_weight.nil? || self.maximum_weight.nil?  
        if self.minimum_weight > self.maximum_weight
          errors.add(:minimum_weight, 'não pode ser maior do que o máximo.')
        end
      end
    end

    def data_intersection
      if PriceLine.where(price_table: self.price_table).any?
        general_minimum_volume = PriceLine.select(:minimum_volume).where(price_table_id: self.price_table_id).min.minimum_volume
        general_maximum_volume = PriceLine.select(:maximum_volume).where(price_table_id: self.price_table_id).max.maximum_volume
        general_minimum_weight = PriceLine.select(:minimum_weight).where(price_table_id: self.price_table_id).min.minimum_weight
        general_maximum_weight = PriceLine.select(:maximum_weight).where(price_table_id: self.price_table_id).max.maximum_weight
        if ((self.minimum_weight >= general_minimum_weight && self.minimum_weight <= general_maximum_weight) ||
          (self.maximum_weight <= general_maximum_weight && self.maximum_weight >= general_maximum_weight)) &&
          ((self.minimum_volume >= general_minimum_volume && self.minimum_volume >= general_minimum_volume) ||
          (self.maximum_volume <= general_maximum_volume && self.maximum_volume >= general_maximum_volume))
          errors.add(:minimum_volume, 'não pode intersectar com outras linhas enquanto o peso tambem o faz.')
          errors.add(:minimum_weight, 'não pode intersectar com outras linhas enquanto o volume tambem o faz.')
        end
      end
    end
end
