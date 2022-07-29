# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'when presence' do
      it 'of everything should be true' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        v = described_class.new(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                                weight_capacity: 8800, shipping_company: sc)

        expect(v).to be_valid
      end

      it 'of everything but plate should be false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        v = described_class.new(plate: '', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                                weight_capacity: 8800, shipping_company: sc)

        expect(v).not_to be_valid
      end

      it 'of everything but brand and model should be false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        v = described_class.new(plate: '8585-POU', brand_model: '', year: '2022', weight_capacity: 8800,
                                shipping_company: sc)

        expect(v).not_to be_valid
      end

      it 'of everything but weight_capacity should be false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        v = described_class.new(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                                weight_capacity: '', shipping_company: sc)

        expect(v).not_to be_valid
      end
    end
  end
end
