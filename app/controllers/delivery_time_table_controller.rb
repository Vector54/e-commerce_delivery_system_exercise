class DeliveryTimeTableController < ApplicationController
  before_action :visit_blocker

  def index
    id = params[:shipping_company_id]
    @delivery_time_table = DeliveryTimeTable.find_by(shipping_company: ShippingCompany.find(id))
    @delivery_time_lines = DeliveryTimeLine.where(delivery_time_table: @delivery_time_table)
  end

  private
    def visit_blocker
      unless user_signed_in? || admin_signed_in?
        redirect_to new_user_session_path
      end
    end
end