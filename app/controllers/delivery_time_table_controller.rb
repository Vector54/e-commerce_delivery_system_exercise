# frozen_string_literal: true

class DeliveryTimeTableController < ApplicationController
  before_action :visit_blocker

  def index
    id = params[:shipping_company_id]
    @delivery_time_table = DeliveryTimeTable.find_by(shipping_company: ShippingCompany.find(id))
    @delivery_time_lines = DeliveryTimeLine.where(delivery_time_table: @delivery_time_table)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
