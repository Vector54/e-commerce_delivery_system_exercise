require 'rails_helper'

RSpec.describe DeliveryTimeLine, type: :model do
  describe '#valid?' do
    context 'Range de distância' do
      it 'mínimo não pode ser maior que máximo' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                      email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                      billing_adress: 'Rua do Seu Carlos, 86', active: true)

        DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, 
                                delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        
        DeliveryTimeLine.create!(init_distance: 101, final_distance: 200, delivery_time: 3, 
                                delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        

        dtl = DeliveryTimeLine.new(init_distance: 250, final_distance: 249, delivery_time: 4, 
                                  delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        
        expect(dtl.valid?).to be false
      end

      it 'não pode interseccionar com o de outra linha' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                      email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                      billing_adress: 'Rua do Seu Carlos, 86', active: true)

        DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, 
                                delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        
        DeliveryTimeLine.create!(init_distance: 101, final_distance: 200, delivery_time: 3, 
                                delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        

        dtl = DeliveryTimeLine.new(init_distance: 50, final_distance: 150, delivery_time: 2, 
                                  delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        
        expect(dtl.valid?).to be false
      end

      it 'pode estar entre outros ranges' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                      email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                      billing_adress: 'Rua do Seu Carlos, 86', active: true)

        DeliveryTimeLine.create!(init_distance: 1, final_distance: 100, delivery_time: 2, 
                                delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        
        DeliveryTimeLine.create!(init_distance: 201, final_distance: 300, delivery_time: 3, 
                                delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        

        dtl = DeliveryTimeLine.new(init_distance: 101, final_distance: 200, delivery_time: 2, 
                                  delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))
        
        expect(dtl.valid?).to be true
      end
    end

    context 'presença' do
      it '- distância inicial faltante' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.new(init_distance: '', final_distance: 150, delivery_time: 2, 
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        expect(dtl.valid?).to be false
      end

      it '- distância final faltante' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.new(init_distance: 50, final_distance: '', delivery_time: 2, 
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        expect(dtl.valid?).to be false
      end

      it '- valor final faltante' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                    email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                    billing_adress: 'Rua do Seu Carlos, 86', active: true)

        dtl = DeliveryTimeLine.new(init_distance: 50, final_distance: 150, delivery_time: '', 
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

        expect(dtl.valid?).to be false
      end
    end
  end
end
