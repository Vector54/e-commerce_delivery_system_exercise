# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceLine, type: :model do
  describe '#valid?' do
    context 'when minimum volume' do
      it 'is bigger than maximum should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 50, maximum_volume: 49, minimum_weight: 5,
                                 maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end
    end

    context 'when volume' do
      it 'intersects with other lines when weight doesn\'t do it should give true' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        described_class.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                                maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        described_class.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 51,
                                maximum_weight: 100, value: 150, price_table: PriceTable.find_by(shipping_company: sc))

        pl = described_class.new(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 101,
                                 maximum_weight: 200, value: 200, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).to be_valid
      end

      it 'intersects with other lines when weight does it should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        described_class.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                                maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        described_class.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 51,
                                maximum_weight: 100, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        pl = described_class.new(minimum_volume: 50, maximum_volume: 4000, minimum_weight: 40,
                                 maximum_weight: 100, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end

      it 'can be inside two ranges.' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        described_class.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5,
                                maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        described_class.create!(minimum_volume: 101, maximum_volume: 200, minimum_weight: 5,
                                maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        pl2 = described_class.new(minimum_volume: 51, maximum_volume: 100, minimum_weight: 5,
                                  maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl2).to be_valid
      end
    end

    context 'when minimum weight' do
      it 'is bigger than maximum should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 51,
                                 maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end
    end

    context 'when presence' do
      it 'of everything should give true' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5,
                                 maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).to be_valid
      end

      it 'of everything but value should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5,
                                 maximum_weight: 50, value: '', price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end

      it 'of everything but minimum volume should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: '', maximum_volume: 50, minimum_weight: 5,
                                 maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end

      it 'of everything but maximum volume should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: '', minimum_weight: 5,
                                 maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end

      it 'of everything but minimum weight should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: '',
                                 maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end

      it 'of everything but maximum weight should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5,
                                 maximum_weight: '', value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        expect(pl).not_to be_valid
      end

      it 'of everything but price table should give false' do
        sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                     email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                     billing_adress: 'Rua do Seu Carlos, 86')

        pl = described_class.new(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5,
                                 maximum_weight: '', value: 100,
                                 price_table: PriceTable.find_by(shipping_company_id: 9999))

        expect(pl).not_to be_valid
      end
    end
  end
end
