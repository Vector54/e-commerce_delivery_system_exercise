# frozen_string_literal: true

class DeliveryTimeTableController < ApplicationController
  before_action :visit_blocker

  def index
    @shipping_company_id = params[:shipping_company_id]
    @delivery_time_lines = DeliveryTimeLine.where(shipping_company_id: @shipping_company_id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
