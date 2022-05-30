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
      flash[:alert] = 'Cadastro falhou.'
      render 'new'
    end
  end

  def edit 
    id = params[:id]
    @vehicle = Vehicle.find(id)
  end

  def update
    id = params[:id]
    parameters = params.require(:vehicle).permit(:plate, :brand_model, :year, :weight_capacity)
    @vehicle = Vehicle.find(id)
    
    if @vehicle.update(parameters)
      redirect_to vehicle_path(id), notice: 'Veículo atualizado com sucesso.'
    else
      flash[:alert] = 'Atualização falhou.'
    end
  end

  def destroy
    id = params[:id]
    @vehicle = Vehicle.find(id)

    @vehicle.destroy

    redirect_to shipping_company_vehicles_path(@vehicle.shipping_company_id)
  end
end