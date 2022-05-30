require 'rails_helper'

RSpec.describe PriceLine, type: :model do
  describe '#valid?' do
    context 'volume' do
      it 'mínimo não pode ser maior que o máximo' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86')

        pl = PriceLine.new(minimum_volume: 50, maximum_volume: 49, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))
          
        expect(pl.valid?).to be false
      end

      it 'pode intersectar com outras linhas quando o peso não o faz.' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86')

        PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 51, 
            maximum_weight: 100, value: 150, price_table: PriceTable.find_by(shipping_company: sc))
            
        pl2 = PriceLine.new(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 101, 
            maximum_weight: 200, value: 200, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl2.valid?).to be true
      end

      it 'não pode instersectar com outras linhas quando o peso o faz.' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86')

        PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 51, 
            maximum_weight: 100, value: 100, price_table: PriceTable.find_by(shipping_company: sc))
            
        pl2 = PriceLine.new(minimum_volume: 50, maximum_volume: 4000, minimum_weight: 40, 
            maximum_weight: 100, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl2.valid?).to be false
      end
    end

    context 'peso' do
      it 'mínimo não pode ser maior que o máximo' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86')

        pl = PriceLine.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 51, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))
          
        expect(pl.valid?).to be false
      end
    end

    context 'valor' do
      it 'presente' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86')

        pl = PriceLine.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
            maximum_weight: 50, value: '', price_table: PriceTable.find_by(shipping_company: sc))
          
        expect(pl.valid?).to be false
      end
    end
  end
end
