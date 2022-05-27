class OrderController < ApplicationController
  def index
    id = params[:shipping_company_id]
    @shipping_company = ShippingCompany.find(id)
    @orders = Order.where(shipping_company: @shipping_company)
  end

  def show
    id = params[:id]
    @order = Order.find(id)
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

  def update
    id = params[:id]
    order_parameters = params.require(:order).permit(:vehicle_id, :status)
    @order = Order.find(id)
    @order.update!(order_parameters)

    redirect_to order_path(id)
  end

end