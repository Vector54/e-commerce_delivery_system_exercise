class PriceTableController < ApplicationController
  def show
    @price_table = PriceTable.find_by(shipping_company: current_user.shipping_company)
    @price_line = PriceLine.where(price_table: @price_table) 
  end
end