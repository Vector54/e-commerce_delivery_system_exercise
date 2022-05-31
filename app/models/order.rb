class Order < ApplicationRecord
  belongs_to :admin
  belongs_to :shipping_company
  has_many :update_lines

  enum status: [:pendente, :ativa, :finalizada, :cancelada]
  before_validation  :set_date, :set_value
  validate :shipping_company_cant_be_inactive, :vehicle_present_when_active, :vehicle_cannot_be_on_another_active_OS
  validates :date, :value, :pickup_adress, :delivery_adress, :product_code, :width, :height, :depth, :cpf, presence: true
  validates :cpf, format: {with: /\A\d{3}\.\d{3}\.\d{3}\-\d{2}\z/, message: 'com formatação inválida.'}
  before_create :set_status, :set_code

  private
    def set_status
      self.status = 0
    end
    
    def set_date
      delivery_times_array = DeliveryTimeLine.where(delivery_time_table: self.shipping_company.delivery_time_table)
      unless self.distance.nil? || delivery_times_array.empty?
     
        delivery_times_array.each do |dtl|
          initial_distance = dtl.init_distance
          final_distance = dtl.final_distance
          days = dtl.delivery_time
          if self.distance < final_distance && self.distance > initial_distance
            self.date = Date.today + days
          end
        end
      end
    end

    def set_value
      price_table = PriceTable.find_by(shipping_company: self.shipping_company)
      price_line_array = PriceLine.where(price_table: price_table)
      
      unless self.distance.nil? || price_line_array.empty? ||
        self.width.nil? || self.height.nil? || self.depth.nil?
        volume = self.width*self.height*self.depth
        
        price_line_array.each do |pl|
          miv = pl.minimum_volume
          mav = pl.maximum_volume
          miw = pl.minimum_weight
          maw = pl.maximum_weight
          if miv < volume && mav > volume &&
            miw < self.weight && maw > self.weight 
            self.value = pl.value*self.distance
          elsif volume < miv || self.weight < miw
            self.value = price_table.minimum_value*self.distance
          end
        end
      end
    end

    def set_code
      self.code = SecureRandom.alphanumeric(15).upcase
    end
    
    def shipping_company_cant_be_inactive
      if self.shipping_company.active == false
        errors.add(:shipping_company, "Transportadora não está ativa.")
      end
    end

    def vehicle_present_when_active
      if self.status == 'ativa' && self.vehicle_id.nil?
        errors.add(:status, 'ativo requer veículo.')
      end
    end

    def vehicle_cannot_be_on_another_active_OS
      active_orders = Order.select(:vehicle_id).where(status: 1) 

      if active_orders.any? && 
        self.status == 'ativa' && self.vehicle_id != nil

        vehicles = Vehicle.select(:id).where(shipping_company_id: self.shipping_company_id, id: active_orders)
        vehicles_ids = vehicles.map {|v| v.id}
        if vehicles_ids.include?(self.vehicle_id)
          errors.add(:vehicle_id, 'já está em outra OS ativa.')
        end
      end
    end
end
