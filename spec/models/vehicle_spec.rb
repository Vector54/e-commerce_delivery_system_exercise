require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'of everything' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86')

        v = Vehicle.new(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                            weight_capacity: 8800, shipping_company: sc)

        expect(v.valid?).to eq true
      end

      it 'of everything but plate' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86')

        v = Vehicle.new(plate: '', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                            weight_capacity: 8800, shipping_company: sc)

        expect(v.valid?).to eq false
      end

      it 'of everything but brand and model' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86')

        v = Vehicle.new(plate: '8585-POU', brand_model: '', year: '2022',
                            weight_capacity: 8800, shipping_company: sc)

        expect(v.valid?).to eq false
      end

      it 'of everything but weight_capacity' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86')

        v = Vehicle.new(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                            weight_capacity: '', shipping_company: sc)

        expect(v.valid?).to eq false
      end
    end
  end
end
