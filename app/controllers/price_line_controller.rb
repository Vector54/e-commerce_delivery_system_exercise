class PriceLineController < ApplicationController
  def new
    @price_line = PriceLine.new()
  end

  def create
    price_line_params = params.require(:price_line).permit(:minimum_volume, :maximum_volume, :minimum_weight, :maximum_weight, :value)

    @price_line = PriceLine.new(price_line_params)
    @price_line.price_table = current_user.shipping_company.price_table
    if @price_line.save
      redirect_to shipping_company_price_table_index_path(current_user.shipping_company)
    else
      flash.now[:alert] = "Cadastro Falhou"
      render 'new'
    end
  end

  def destroy
    id = params[:id]
    @price_line = PriceLine.find(id)
    @price_line.delete

    redirect_to shipping_company_price_table_index_path(@price_line.price_table.shipping_company_id)
  end
end