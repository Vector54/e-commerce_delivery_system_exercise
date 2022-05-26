class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    vehicle_params = params.require(:vehicle).permit(:plate, :brand_model, :year, :weight_capacity)

    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.shipping_company = current_user.shipping_company
    if @vehicle.save
      redirect_to vehicles_path, notice: 'Cadastro realizado com sucesso.'
    else
      flash.now[:alert] = 'Cadastro falhou.'
      render 'new'
    end
  end
end