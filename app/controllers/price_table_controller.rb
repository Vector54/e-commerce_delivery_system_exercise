class PriceTableController < ApplicationController
  def show
    id = params[:id]
    @price_table = PriceTable.find_by(shipping_company: ShippingCompany.find(id))
    @price_line = PriceLine.where(price_table: @price_table) 
  end
end