require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'Gera um código aleatório' do
      it 'ao criar um pedido' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                                      delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
                              maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))                                    
        
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save                                    

        os = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )

        r = os.code
        
        expect(r).not_to be_empty
        expect(r.length).to eq 15 
      end

      it 'único para o pedido' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                                      delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
                              maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))                                    
        
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save                                    

        os1 = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )


        os2 = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )

        r = os1.code
        
        expect(r).not_to eq os2.code
      end
    end

    context 'Criação:'  do
      it 'com sucesso' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be true
      end
    end
  end
end
