# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateLine, type: :model do
  describe '#valid?' do
    it 'coordinates presence true' do
      sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                   email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                   billing_adress: 'Rua do Seu Carlos, 86', active: true)

      a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
      a.confirm
      a.save

      dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, shipping_company: sc)

      pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                             maximum_weight: 50, value: 100, shipping_company: sc)

      v =  Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                           weight_capacity: 8800, shipping_company: sc)

      os = Order.create!(admin: a, weight: 10, shipping_company: sc,
                         distance: 95, pickup_adress: 'Rua de Retirada, 45',
                         product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                         delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')

      ul = described_class.new(coordinates: '87.98465, 8.65498', order: os)

      expect(ul).to be_valid
    end

    it 'coordinates presence false' do
      sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                   email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                   billing_adress: 'Rua do Seu Carlos, 86', active: true)

      a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
      a.confirm
      a.save

      dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, shipping_company: sc)

      pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                             maximum_weight: 50, value: 100, shipping_company: sc)

      v =  Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                           weight_capacity: 8800, shipping_company: sc)

      os = Order.create!(admin: a, weight: 10, shipping_company: sc,
                         distance: 95, pickup_adress: 'Rua de Retirada, 45',
                         product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                         delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')

      ul = described_class.new(coordinates: '', order: os)

      expect(ul).not_to be_valid
    end

    it 'coordinates format invalid' do
      sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                   email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                   billing_adress: 'Rua do Seu Carlos, 86', active: true)

      a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
      a.confirm
      a.save

      dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, shipping_company: sc)

      pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                             maximum_weight: 50, value: 100, shipping_company: sc)

      v =  Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                           weight_capacity: 8800, shipping_company: sc)

      os = Order.create!(admin: a, weight: 10, shipping_company: sc,
                         distance: 95, pickup_adress: 'Rua de Retirada, 45',
                         product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                         delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')

      ul = described_class.new(coordinates: '64684 545', order: os)

      expect(ul).not_to be_valid
    end
  end
end
