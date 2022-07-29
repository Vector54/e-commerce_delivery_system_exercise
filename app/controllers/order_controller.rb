# frozen_string_literal: true

class OrderController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :visit_blocker, except: %i[search show]

  def index
    id = params[:shipping_company_id]
    @shipping_company = ShippingCompany.find(id)
    @orders = Order.where(shipping_company: @shipping_company)
  end

  def show
    id = params[:id]
    @order = Order.find(id)
    @update_lines = UpdateLine.where(order: @order)
    @update_line_new = UpdateLine.new
    @ids = Order.select(:vehicle_id).where(status: 1)
    @vehicles = Vehicle.where(shipping_company_id: @order.shipping_company_id).where.not(id: @ids)
  end

  def new
    @id = params[:shipping_company_id]
    @order = Order.new
  end

  def create
    id = params[:shipping_company_id]
    order_parameters = params.require(:order).permit(:pickup_adress, :product_code, :width,
                                                     :height, :depth, :delivery_adress,
                                                     :cpf, :weight, :delivery_adress, :distance)
    @order = Order.new(order_parameters)
    @order.admin = current_admin
    @order.shipping_company = ShippingCompany.find(id)

    if @order.save
      redirect_to order_path(@order.id), notice: t('.success')
    else
      errors = @order.errors.full_messages.join(', ')
      flash.now[:alert] = t('.failure') + errors
      render 'new'
    end
  end

  def new_ul
    raw_line_params = params.permit(:latitude, :longitude, :order)
    str_line_params = "#{raw_line_params[:latitude]}, #{raw_line_params[:longitude]}"

    update_line = UpdateLine.new(coordinates: str_line_params, order_id: raw_line_params[:order])

    if update_line.save
      redirect_to order_path(update_line.order.id), notice: t('.success')
    else
      errors = update_line.errors.full_messages.join(', ')
      redirect_to order_path(update_line.order.id), notice: t('.failure') + errors
    end
  end

  def update
    id = params[:id]
    order_parameters = params.require(:order).permit(:vehicle_id, :status)
    @order = Order.find(id)
    @order.update!(order_parameters)

    redirect_to order_path(id)
  end

  def search
    code = params[:query]
    @order = Order.find_by(code: code)
    @update_lines = UpdateLine.where(order: @order)
    if @order.is_a?(Order)
      render :show
    else
      flash[:alert] = t('.no_results')
      redirect_to root_path
    end
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
