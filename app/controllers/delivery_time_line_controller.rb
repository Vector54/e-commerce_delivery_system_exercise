class DeliveryTimeLineController < ApplicationController
  def new
    @delivery_time_line = DeliveryTimeLine.new()
  end

  def create
    delivery_time_line_params = params.require(:delivery_time_line).permit(:init_distance, :final_distance, :delivery_time)

    @delivery_time_line = DeliveryTimeLine.new(delivery_time_line_params)
    @delivery_time_line.delivery_time_table = current_user.shipping_company.delivery_time_table
    if @delivery_time_line.save
      redirect_to delivery_time_table_path(DeliveryTimeTable.find_by(shipping_company: current_user.shipping_company))
    else
      flash.now[:alert] = "Cadastro Falhou"
      render 'new'
    end
  end
end