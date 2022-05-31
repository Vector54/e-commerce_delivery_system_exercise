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
    volume = parameters_raw[:width].to_i*parameters_raw[:height].to_i*parameters_raw[:depth].to_i
    
    pls = []
    dtls = []
    ShippingCompany.where(active: true).each do |sca|
      sca.delivery_time_table.delivery_time_lines.each do |dtla|
        dtls << dtla
      end
      sca.price_table.price_lines.each do |pla|
        pls << pla
      end
    end

    dtls_1_filter = []
    dtls.each do |dtl|
      if dtl.init_distance < parameters_raw[:distance].to_i && dtl.final_distance > parameters_raw[:distance].to_i
        dtls_1_filter << dtl
      end
    end

    pls_1_filter = []
    pls.each do |pl|
      if pl.minimum_volume < volume && pl.maximum_volume > volume &&
        pl.minimum_weight < parameters_raw[:weight].to_i && pl.maximum_weight > parameters_raw[:weight].to_i
        pls_1_filter << pl
      end
    end
    
    ls_2_filter = []
    pls_1_filter.each do |pl|
      dtls_1_filter.each do |dtl|
        if dtl.delivery_time_table.shipping_company == pl.price_table.shipping_company
          hash = {dtl: dtl, pl: pl}
          ls_2_filter << hash
        end
      end
    end

    @hashes = []

    ls_2_filter.each do |hash|
      name = hash[:dtl].delivery_time_table.shipping_company.name
      id = hash[:dtl].delivery_time_table.shipping_company.id
      value = hash[:pl].value * parameters_raw[:distance].to_i
      days = hash[:dtl].delivery_time
      f_hash = {name: name, id: id, value: value, days: days}
      @hashes << f_hash
    end

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