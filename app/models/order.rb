class Order < ApplicationRecord
  belongs_to :admin
  belongs_to :shipping_company

  enum status: [:pendente, :ativa, :finalizada, :cancelada]
  before_validation  :set_date, :set_value
  validates :date, :value, presence: true
  before_create :set_status, :set_code

  private
    def set_status
      self.status = 0
    end
    
    def set_date
      delivery_times_array = DeliveryTimeLine.where(delivery_time_table: self.shipping_company.delivery_time_table)
     
      delivery_times_array.each do |dtl|
        initial_distance = dtl.init_distance
        final_distance = dtl.final_distance
        days = dtl.delivery_time
        if self.distance < final_distance && self.distance > initial_distance
          self.date = Date.today + days
        end
      end
    end

    def set_value
      volume = self.width*self.height*self.depth
      peso = self.weight
      price_line_array = PriceLine.where(price_table: self.shipping_company.price_table)

      price_line_array.each do |pl|
        miv = pl.minimum_volume
        mav = pl.maximum_volume
        miw = pl.minimum_weight
        maw = pl.maximum_weight
        final_value = pl.value*self.distance
        if miv < volume &&
           mav > volume &&
           miw < self.weight &&
           maw > self.weight 
          self.value = final_value
        end
      end
    end

    def set_code
      self.code = SecureRandom.alphanumeric(15).upcase
    end
end
