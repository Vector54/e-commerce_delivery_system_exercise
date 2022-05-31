class ShippingCompaniesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :index, :budget_query, :budget_response]
  before_action :visit_blocker, only: :show


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

  def edit
    id = params[:id]
    @shipping_company = ShippingCompany.find(id)
  end

  def update
    id = params[:id]
    parameters = params.require(:shipping_company).permit(:name, :corporate_name, :email_domain,
                                                        :cnpj, :billing_adress)
    

    @shipping_company = ShippingCompany.find(id)

    if @shipping_company.update(parameters)
      redirect_to shipping_company_path(id), notice: 'Transportadora atualizada com sucesso.'
    else
      flash[:alert] = 'Falha na atualização, por favor, revise os dados.'
      render 'edit'
    end
  end

  def status_change
    id = params[:id]
    param_status = params.permit(:active)

    @shipping_company = ShippingCompany.find(id)
    
    if @shipping_company.update(param_status)
      redirect_to shipping_company_path(id), notice: 'Status atualizado com sucesso.'
    else
      flash[:alert] = 'Falha na atualização, por favor, revise os dados.'
      render 'edit'
    end
  end
  
  def budget_query;  end

  def budget_response
    parameters_raw = params.permit(:width, :height, :depth, :weight, :distance)
    @hashes = BudgetFinder.find_budgets(parameters_raw)

    if @hashes.empty?
      redirect_to budget_query_shipping_companies_path, alert: 'Nenhum resultado encontrado.'
    end
  end

  private
    def visit_blocker
      unless user_signed_in? || admin_signed_in?
        redirect_to new_user_session_path
      end
    end
end