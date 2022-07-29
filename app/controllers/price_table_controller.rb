# frozen_string_literal: true

class PriceTableController < ApplicationController
  before_action :visit_blocker

  def index
    shipping_company_id = params[:shipping_company_id]
    @shipping_company = ShippingCompany.find(shipping_company_id)
    @price_line = PriceLine.where(shipping_company: shipping_company_id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
