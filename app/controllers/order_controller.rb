class OrderController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create]
  before_action :visit_blocker, except: [:search, :show]
  

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
    @new_order = Order.new(order_parameters)
    @new_order.admin = current_admin
    @new_order.shipping_company = ShippingCompany.find(id)
    
    if @new_order.save
      redirect_to order_path(@new_order.id), notice: 'Cadastro realizado com sucesso.'
    else
      flash.now[:alert] = 'Cadastro falhou.'
      render 'new'
    end 
  end

  def new_ul
    raw_line_params = params.permit(:latitude, :longitude, :order)
    str_line_params = raw_line_params[:latitude].to_s+ ', ' + raw_line_params[:longitude].to_s

    ul = UpdateLine.new(coordinates: str_line_params)
    ul.order = Order.find(raw_line_params[:order].to_i)
    ul.save!
    
    redirect_to order_path(ul.order.id)
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
      flash[:alert] = 'Nenhum resultado para a pesquisa.'
      redirect_to root_path
    end
  end

  private
  def visit_blocker
    unless user_signed_in? || admin_signed_in?
      redirect_to new_user_session_path
    end
  end

end