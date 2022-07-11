# frozen_string_literal: true

class ShippingCompaniesController < ApplicationController
  before_action :authenticate_admin!, only: %i[new index budget_query budget_response]
  before_action :visit_blocker, only: [:show, :minimum_value_update]

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
      redirect_to @new_sc, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @shipping_company = ShippingCompany.find(id)
  end

  def update
    id = params[:id]
    parameters = params.require(:shipping_company).permit(:name, :corporate_name, :email_domain, :cnpj, :billing_adress)

    @shipping_company = ShippingCompany.find(id)

    if @shipping_company.update(parameters)
      redirect_to shipping_company_path(id), notice: t('.success')
    else
      errors = @shipping_company.errors.full_messages.join(',')
      flash[:alert] = t('.failure') + errors
      render 'edit'
    end
  end

  def status_change
    # could be set directly on update
    id = params[:id]
    param_status = params.permit(:active)

    @shipping_company = ShippingCompany.find(id)
    @shipping_company.update(param_status)

    redirect_to shipping_company_path(id), notice: t('.success')
  end

  def minimum_value_update
    id = params[:id]
    parameters = params.require(:shipping_company).permit(:minimum_value)
    @shipping_company = ShippingCompany.find(id)
    formated_value = parameters[:minimum_value].tr(',', '').to_i
    @shipping_company.update!('minimum_value' => formated_value.to_s)

    redirect_to shipping_company_price_table_index_path(@shipping_company)
  end

  def budget_query; end

  def budget_response
    parameters_raw = params.permit(:width, :height, :depth, :weight, :distance)
    @hashes = BudgetFinder.find_budgets(parameters_raw)

    redirect_to budget_query_shipping_companies_path, alert: t('.no_results') if @hashes.empty?
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
