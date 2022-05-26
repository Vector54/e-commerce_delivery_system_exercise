class DeliveryTimeTableController < ApplicationController
  def show
    delivery_time_table = DeliveryTimeTable.find_by(shipping_company: current_user.shipping_company)
    @delivery_time_line = DeliveryTimeLine.where(delivery_time_table: delivery_time_table)
  end
end