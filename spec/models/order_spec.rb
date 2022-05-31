require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'Gera um código aleatório' do
      it 'ao criar um pedido' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
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
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
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
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
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

      it 'sem distância' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: '', pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end

      it 'sem endereço de retirada' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 70, pickup_adress: '',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end

      it 'sem endereço de entrega' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 70, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: '', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end

      it 'sem código do produto' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: '', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end

      it 'sem largura' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: '', height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end

      it 'sem altura' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 2, height: '', depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end

      it 'sem profundidade' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 2, height: 2, depth: '', 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )
        
        expect(os1.valid?).to be false
      end
      
      it 'sem cpf' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 2, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '' )
        
        expect(os1.valid?).to be false
      end

      it 'com cpf inválido' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc)) 
            
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        os1 = Order.new(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 2, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.58-86' )
        
        expect(os1.valid?).to be false
      end

      it 'trasportadora desativada' do 
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)
        sc.update("active"=>"false")

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
        
        expect(os1.valid?).to be false
      end

      it 'valor mínimo' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                  email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                  billing_adress: 'Rua do Seu Carlos, 86')

        PriceTable.find_by(shipping_company: sc).update!("minimum_value"=>"25")                                  
        sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
                      email_domain:"seumeirelesfrete.com.br", cnpj: "06.902.578/0001-57",
                      billing_adress: 'Rua do Seu Meireles, 68')
        PriceTable.find_by(shipping_company: sc2).update!("minimum_value"=>"25")
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save

        dtl1_1 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl1_1 = PriceLine.create!(minimum_volume: 5, maximum_volume: 50, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

        dtl2_1 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 4, 
            delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl2_1 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
        maximum_weight: 70, value: 150, price_table: PriceTable.find_by(shipping_company: sc))

        dtl1_2 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 3, 
        delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

        pl1_2 = PriceLine.create!(minimum_volume: 5, maximum_volume: 50, minimum_weight: 5, 
        maximum_weight: 50, value: 50, price_table: PriceTable.find_by(shipping_company: sc2))

        dtl2_2 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 6, 
        delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

        pl2_2 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
        maximum_weight: 70, value: 100, price_table: PriceTable.find_by(shipping_company: sc2))

        os = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 75, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 1, depth: 1, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )

        expect(os.value).to eq 1875
      end
    end

    context 'Status ativo:' do
      it 'Uma OS ativa deve possuir um veículo' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)

        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save                                  

        dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, 
                    delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
            maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))                                    

        Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
            weight_capacity: 8800, shipping_company: sc)                                  
            
        Vehicle.create!(plate: '7555-IOU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
            weight_capacity: 8800, shipping_company: sc)

        os = Order.new(admin: a, weight: 10,
                    shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                    product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                    delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86', status: :ativa)
        
        expect(os.valid?).to be false
      end

      it 'Usuário não pode atrelar veículo se o mesmo estiver em outra OS ativa' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)
    
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save                                  
    
        dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, 
                                      delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
    
        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
                              maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))                                    
    
        v = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                              weight_capacity: 8800, shipping_company: sc)                                  
                              
        o = Order.create!(admin: a, weight: 10,
                          shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                          product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                          delivery_adress: 'Rua de Primeira, 54', cpf: '568.568.568-86')
        
        o.update!("status" => "ativa", "vehicle_id" => "1")

        os = Order.new(admin: a, weight: 10,
                          shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                          product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                          delivery_adress: 'Rua de Segunda, 54', cpf: '568.568.568-86', status: :ativa, vehicle_id: v.id)
                          
        expect(os.valid?).to be false         
      end

      it 'Usuário pode atrelar veículo se o mesmo não estiver em outra OS ativa' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)
    
        a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
        a.confirm
        a.save                                  
    
        dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, 
                                      delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
    
        pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
                              maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))                                    
    
        v = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                              weight_capacity: 8800, shipping_company: sc)
                              
        v2 = Vehicle.create!(plate: '5758-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                              weight_capacity: 8800, shipping_company: sc)  
                              
        os1 = Order.create!(admin: a, weight: 10,
                          shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                          product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                          delivery_adress: 'Rua de Primeira order, 54', cpf: '568.568.568-86')

        os1.update!("status"=>"ativa", "vehicle_id"=>"#{v.id}")

        os2 = Order.new(admin: a, weight: 10,
                          shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                          product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                          delivery_adress: 'Rua de Segunda order, 54', cpf: '568.568.568-86', status: :ativa, vehicle_id: v2.id)
                          
        expect(os2.valid?).to be true         
      end
    end
  end
end
