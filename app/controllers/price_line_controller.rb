# frozen_string_literal: true

class PriceLineController < ApplicationController
  before_action :visit_blocker

  def new
    @price_line = PriceLine.new
  end

  def create
    price_line_params = params.require(:price_line).permit(:minimum_volume, :maximum_volume, :minimum_weight,
                                                           :maximum_weight, :value)
    formated_value = price_line_params[:value].tr(',', '').to_i

    @price_line = PriceLine.new(price_line_params)
    @price_line.shipping_company = current_user.shipping_company
    @price_line.value = formated_value
    if @price_line.save
      flash[:notice] = t('.success')
      redirect_to shipping_company_price_table_index_path(current_user.shipping_company)
    else
      errors = @price_line.errors.full_messages.join(', ')
      flash.now[:alert] = t('.failure') + errors
      render 'new'
    end
  end

  def destroy
    id = params[:id]
    @price_line = PriceLine.find(id)
    @price_line.delete

    redirect_to shipping_company_price_table_index_path(@price_line.shipping_company_id)
  end

  private

  def visit_blocker
    redirect_to new_user_session_path unless user_signed_in? || admin_signed_in?
  end
end
