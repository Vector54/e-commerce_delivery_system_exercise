# frozen_string_literal: true

class DeliveryTimeLineController < ApplicationController
  before_action :visit_blocker

  def new
    @delivery_time_line = DeliveryTimeLine.new
  end

  def create
    delivery_time_line_params = params.require(:delivery_time_line).permit(:init_distance, :final_distance,
                                                                           :delivery_time)

    @delivery_time_line = DeliveryTimeLine.new(delivery_time_line_params)
    @delivery_time_line.delivery_time_table = current_user.shipping_company.delivery_time_table
    if @delivery_time_line.save
      redirect_to shipping_company_delivery_time_table_index_path(current_user.shipping_company)
    else
      flash.now[:alert] = 'Cadastro Falhou'
      render 'new'
    end
  end

  def destroy
    id = params[:id]

    @delivery_time_line = DeliveryTimeLine.find(id)
    @delivery_time_line.delete

    redirect_to shipping_company_delivery_time_table_index_path(@delivery_time_line
                                                                .delivery_time_table.shipping_company_id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
