class PriceLineController < ApplicationController
  def new
    @price_line = PriceLine.new()
  end

  def create
    price_line_params = params.require(:price_line).permit(:minimum_volume, :maximum_volume, :minimum_weight, :maximum_weight, :value)

    @price_line = PriceLine.new(price_line_params)
    @price_line.price_table = current_user.shipping_company.price_table
    if @price_line.save
      redirect_to price_table_path(PriceTable.find_by(shipping_company: current_user.shipping_company))
    else
      flash.now[:alert] = "Cadastro Falhou"
      render 'new'
    end
  end
end