class PriceTableController < ApplicationController
  def index
    id = params[:shipping_company_id]
    @price_table = PriceTable.find_by(shipping_company: ShippingCompany.find(id))
    @price_line = PriceLine.where(price_table: @price_table) 
  end
end