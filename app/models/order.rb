# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :admin
  belongs_to :shipping_company
  has_many :update_lines, dependent: :destroy

  enum status: { pendente: 0, ativa: 1, finalizada: 2, cancelada: 3 }
  before_validation :set_date, :set_value
  validate :shipping_company_cant_be_inactive, :vehicle_present_when_active, :vehicle_cannot_be_on_another_active_os
  validates :date, :value, :pickup_adress, :delivery_adress, :product_code, :width, :height, :depth, :cpf,
            presence: true
  validates :cpf, format: { with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/ }
  before_create :set_code

  private

  # Lacking admin confirmation validation

  def set_date
    delivery_times_array = DeliveryTimeLine.where(shipping_company: shipping_company)
    unless distance.nil? || delivery_times_array.empty?

      delivery_times_array.each do |dtl|
        initial_distance = dtl.init_distance
        final_distance = dtl.final_distance
        days = dtl.delivery_time
        self.date = Time.zone.today + days if distance < final_distance && distance > initial_distance
      end
    end
  end

  def set_value
    price_line_array = PriceLine.where(shipping_company: shipping_company)

    unless distance.nil? || price_line_array.empty? || width.nil? || height.nil? || depth.nil?
      volume = width * height * depth

      price_line_array.each do |pl|
        miv = pl.minimum_volume
        mav = pl.maximum_volume
        miw = pl.minimum_weight
        maw = pl.maximum_weight
        if miv < volume && mav > volume && miw < weight && maw > weight
          # Weight validation doesn't seem to be working
          self.value = pl.value * distance
        elsif volume < miv || weight < miw
          self.value = shipping_company.minimum_value * distance
        end
      end
    end
  end

  def set_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def shipping_company_cant_be_inactive
    errors.add(:shipping_company, ' não está ativa.') unless shipping_company.active?
  end

  def vehicle_present_when_active
    errors.add(:status, 'ativo requer veículo.') if status == 'ativa' && vehicle_id.nil?
  end

  def vehicle_cannot_be_on_another_active_os
    active_orders = Order.select(:vehicle_id).where(status: 1)

    if active_orders.any? && status == 'ativa' && !vehicle_id.nil?

      vehicles = Vehicle.select(:id).where(shipping_company_id: shipping_company_id, id: active_orders)
      vehicles_ids = vehicles.map(&:id)
      errors.add(:vehicle_id, 'já está em outra OS ativa.') if vehicles_ids.include?(vehicle_id)
    end
  end
end
