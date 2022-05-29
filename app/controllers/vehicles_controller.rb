class VehiclesController < ApplicationController
  def index
    @id = params[:shipping_company_id]
    @vehicles = Vehicle.where(shipping_company: ShippingCompany.find(@id))
  end

  def show
    id = params[:id]
    @vehicle = Vehicle.find(id)
  end

  def new
    @id = params[:shipping_company_id]
    @vehicle = Vehicle.new
  end

  def create
    id = params[:shipping_company_id]
    vehicle_params = params.require(:vehicle).permit(:plate, :brand_model, :year, :weight_capacity)

    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.shipping_company = ShippingCompany.find(id)
    if @vehicle.save
      redirect_to "/shipping_companies/#{id}/vehicles", notice: 'Cadastro realizado com sucesso.'
    else
      flash.now[:alert] = 'Cadastro falhou.'
      render 'new'
    end
  end
end