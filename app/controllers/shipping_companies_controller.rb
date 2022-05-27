class ShippingCompaniesController < ApplicationController
  def index
    @shipping_companies = ShippingCompany.all
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