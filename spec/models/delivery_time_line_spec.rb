# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryTimeLine, type: :model do
  describe '#valid?' do
    context 'when distance' do
      it 'minimum is bigger than maximum, should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = described_class.new(init_distance: 250, final_distance: 249, 
                                  delivery_time: 4, shipping_company: sc)

        expect(dtl).not_to be_valid
      end

      it 'intesects with other line\'s distance' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        described_class.create!(init_distance: 0, final_distance: 100, delivery_time: 2, shipping_company: sc)

        described_class.create!(init_distance: 101, final_distance: 200, delivery_time: 4, shipping_company: sc)

        dtl = described_class.new(init_distance: 50, final_distance: 150, 
                                  delivery_time: 3, shipping_company: sc)

        expect(dtl).not_to be_valid
      end

      it 'is within other line\'s distances' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        described_class.create!(init_distance: 0, final_distance: 100, delivery_time: 2, shipping_company: sc)

        described_class.create!(init_distance: 201, final_distance: 300, delivery_time: 4, shipping_company: sc)

        dtl = described_class.new(init_distance: 101, final_distance: 200, 
                                  delivery_time: 3, shipping_company: sc)

        expect(dtl).to be_valid
      end
    end

    context 'when presence' do
      it 'of everything, should give true' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = described_class.new(init_distance: 101, final_distance: 200, 
                                  delivery_time: 3, shipping_company: sc)

        expect(dtl).to be_valid
      end

      it 'of everything but initial distance, should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = described_class.new(init_distance: '', final_distance: 200, 
                                  delivery_time: 3, shipping_company: sc)

        expect(dtl).not_to be_valid
      end

      it 'of everything but final distance, should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = described_class.new(init_distance: 101, final_distance: '', 
                                  delivery_time: 3, shipping_company: sc)

        expect(dtl).not_to be_valid
      end

      it 'of everything but delivery time, should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = described_class.new(init_distance: 101, final_distance: 200, 
                                  delivery_time: '', shipping_company: sc)

        expect(dtl).not_to be_valid
      end
    end
  end
end
