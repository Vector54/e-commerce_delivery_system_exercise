# frozen_string_literal: true

class PriceTableController < ApplicationController
  before_action :visit_blocker

  def index
    id = params[:shipping_company_id]
    @price_table = PriceTable.find_by(shipping_company: ShippingCompany.find(id))
    @price_line = PriceLine.where(price_table: @price_table)
  end

  def update
    id = params[:id]
    parameters = params.require(:price_table).permit(:minimum_value)
    @price_table = PriceTable.find(id)
    formated_value = parameters[:minimum_value].tr(',', '').to_i
    @price_table.update!('minimum_value' => formated_value.to_s)

    redirect_to shipping_company_price_table_index_path(@price_table.shipping_company_id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
