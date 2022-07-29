# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :visit_blocker

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
      redirect_to "/shipping_companies/#{id}/vehicles", notice: t('.success')
    else
      errors = @vehicle.errors.full_messages.join(', ')
      flash[:alert] = t('.failure') + errors
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
      redirect_to vehicle_path(id), notice: t('.success')
    else
      errors = @vehicle.errors.full_messages.join(', ')
      flash[:alert] = t('.failure') + errors
      render 'edit'
    end
  end

  def destroy
    id = params[:id]
    @vehicle = Vehicle.find(id)

    @vehicle.destroy

    redirect_to shipping_company_vehicles_path(@vehicle.shipping_company_id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
