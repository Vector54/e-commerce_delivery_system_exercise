class PriceTableController < ApplicationController
  before_action :visit_blocker

  def index
    id = params[:shipping_company_id]
    @price_table = PriceTable.find_by(shipping_company: ShippingCompany.find(id))
    @price_line = PriceLine.where(price_table: @price_table) 
  end

  private
    def visit_blocker
      unless user_signed_in? || admin_signed_in?
        redirect_to new_user_session_path
      end
    end
end