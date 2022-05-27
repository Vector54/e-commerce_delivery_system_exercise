class DeliveryTimeTableController < ApplicationController
  def show
    id = params[:id]
    @delivery_time_table = DeliveryTimeTable.find_by(shipping_company: ShippingCompany.find(id))
    @delivery_time_line = DeliveryTimeLine.where(delivery_time_table: @delivery_time_table)
  end
end