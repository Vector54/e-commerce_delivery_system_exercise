# frozen_string_literal: true

class BudgetFinder < ApplicationService
  attr_reader :parameters_raw

  def initialize(parameters_raw)
    @parameters_raw = parameters_raw
  end

  def find_budgets
    volume = @parameters_raw[:width].to_i * @parameters_raw[:height].to_i * @parameters_raw[:depth].to_i
    active_shipping_companies = ShippingCompany.where(active: true)
    hashes = []

    active_shipping_companies.each do |sca|
      selected_pl = nil
      selected_dtl = nil

      PriceLine.where(shipping_company: sca).each do |pl|
        if pl.minimum_volume < volume && pl.maximum_volume > volume &&
           pl.minimum_weight < @parameters_raw[:weight].to_i && pl.maximum_weight > @parameters_raw[:weight].to_i
          selected_pl = pl
        elsif volume < PriceLine.select(:minimum_volume).where(shipping_company: sca).min.minimum_volume ||
              @parameters_raw[:weight].to_i < PriceLine.select(:minimum_weight)
                                                       .where(shipping_company: sca).min.minimum_weight
          selected_pl = sca
        end
      end

      DeliveryTimeLine.where(shipping_company: sca).each do |dtl|
        if dtl.init_distance < @parameters_raw[:distance].to_i && dtl.final_distance > @parameters_raw[:distance].to_i
          selected_dtl = dtl
        end
      end

      next if selected_pl.nil? || selected_dtl.nil?

      case selected_pl
      when PriceLine
        value = selected_pl.value * @parameters_raw[:distance].to_i
      when ShippingCompany
        value = selected_pl.minimum_value * @parameters_raw[:distance].to_i
      end
      hash = { name: sca.name, id: sca.id, value: value, days: selected_dtl.delivery_time }
      hashes << hash
    end

    hashes
  end
end
