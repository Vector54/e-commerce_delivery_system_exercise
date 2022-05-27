class ShippingCompaniesController < ApplicationController
  def index
    @shipping_companies = ShippingCompany.all
  end

  def orders
    id = params[:id]
    @shipping_company = ShippingCompany.find(id)
    @orders = Order.where(shipping_company: @shipping_company)
  end

  def new_order
    @id = params[:id]
    @order = Order.new
  end

  def show_order
    id = params[:id]
    @order = Order.find(id)
  end

  def create_order
    id = params[:id]
    order_parameters = params.require(:order).permit(:pickup_adress, :product_code, :width,
                                                      :height, :depth, :delivery_adress, 
                                                      :cpf, :weight, :delivery_adress, :distance)
    @new_order = Order.new(order_parameters)
    @new_order.admin = current_admin
    @new_order.shipping_company = ShippingCompany.find(id)
    
    if @new_order.save
      redirect_to show_order_path(@new_order.id), notice: 'Cadastro realizado com sucesso.'
    else
      flash.now[:alert] = 'Cadastro falhou.'
      render 'new'
    end 
  end

  def show
    id = params[:id]
    @shipping_company = ShippingCompany.find(id)
  end

  def new
    @shipping_company = ShippingCompany.new
  end

  def create
    sc_parameters = params.require(:shipping_company).permit(:name, :corporate_name, :cnpj,
                                                      :billing_adress, :active, :email_domain)
    @new_sc = ShippingCompany.new(sc_parameters)
    
    if @new_sc.save
      redirect_to @new_sc, notice: 'Cadastro realizado com sucesso.'
    else
      flash.now[:alert] = 'Cadastro falhou.'
      render 'new'
    end
  end
end