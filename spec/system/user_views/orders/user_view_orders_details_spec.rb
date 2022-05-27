require 'rails_helper'

describe 'Usuário acessa detalhe de uma OS' do 
  it 'e os vê' do
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

    os = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )                                  

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Ordens de Serviço'
    click_on os.code

    expect(page).to have_content os.code
    expect(page).to have_content "Transportadora - #{os.shipping_company.name}"
    expect(page).to have_content "Distância Km - #{os.distance}"
    expect(page).to have_content "Orçamento - R$95,00"
    expect(page).to have_content "Data de entrega - #{os.date}"
    expect(page).to have_content "Código do produto - #{os.product_code}"
    expect(page).to have_content "Volume m³ - #{os.width*os.height*os.depth}"
    expect(page).to have_content "Peso Kg - #{os.weight}"
    expect(page).to have_content "Endereço de retirada - #{os.pickup_adress}"
    expect(page).to have_content "Endereço de entrega - #{os.delivery_adress}"
    expect(page).to have_content "CPF do destinatário - #{os.cpf}"
    expect(page).to have_content "Admin responsável - #{os.admin.email}"
    expect(page).to have_content "Status - #{os.status}"
    expect(page).to have_button 'Aceitar'
    expect(page).to have_field 'Veículo'
    expect(page).to have_button 'Negar'
  end

  it 'e vê atualizações' do
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

    v =  Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                          weight_capacity: 8800000, shipping_company: sc)                                  

    os = Order.create!(admin: a, weight: 10, shipping_company: sc,
                      distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')
                      
    ul = UpdateLine.create!(coordinates: '1456 - 1564', order: os)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Ordens de Serviço'
    click_on os.code
    select v.plate, from: 'Veículo'
    click_on 'Aceitar'

    expect(page).to have_content "#{ul.created_at} -------------- #{ul.coordinates}"
    expect(page).to have_button 'Atualizar'
    expect(page).to have_field 'Latitude'
    expect(page).to have_field 'Longitude'
    expect(page).to have_button 'Finalizar'
    expect(page).to have_button 'Cancelar'
  end
  
  it 'e aceita uma OS' do
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
                          weight_capacity: 8800000, shipping_company: sc)                                  
                          
    Vehicle.create!(plate: '7555-IOU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                          weight_capacity: 8800000, shipping_company: sc)

    os = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )                                  

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Ordens de Serviço'
    click_on os.code
    select '8585-POU', from: 'Veículo'
    click_on 'Aceitar'

    expect(page).to have_content "Status - ativa"
    expect(page).to have_content "Veículo - 8585-POU"
    expect(page).not_to have_button 'Aceitar'
    expect(page).not_to have_field 'Veículo'
    expect(page).not_to have_button 'Negar'
  end

  it 'e nega uma OS' do
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
                          weight_capacity: 8800000, shipping_company: sc)                                  
                          
    Vehicle.create!(plate: '7555-IOU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                          weight_capacity: 8800000, shipping_company: sc)

    os = Order.create!(admin: a, weight: 10,
                      shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86' )                                  

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Ordens de Serviço'
    click_on os.code
    select '8585-POU', from: 'Veículo'
    click_on 'Negar'

    expect(page).to have_content "Status - cancelada"
    expect(page).not_to have_button 'Aceitar'
    expect(page).not_to have_field 'Veículo'
    expect(page).not_to have_button 'Negar'
  end

  it 'e faz uma atualização' do
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

    v =  Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                          weight_capacity: 8800000, shipping_company: sc)                                  

    os = Order.create!(admin: a, weight: 10, shipping_company: sc,
                      distance: 95, pickup_adress: 'Rua de Retirada, 45',
                      product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2, 
                      delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')
                      
    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Ordens de Serviço'
    click_on os.code
    select v.plate, from: 'Veículo'
    click_on 'Aceitar'
    fill_in 'Latitude', with: '4658765'
    fill_in 'Longitude', with: '5751654'
    click_on 'Atualizar'

    ul = UpdateLine.last
    expect(ul.coordinates).not_to be_empty
    expect(page).to have_content "#{ul.created_at} -------------- #{ul.coordinates}"
    expect(page).to have_button 'Atualizar'
    expect(page).to have_field 'Latitude'
    expect(page).to have_field 'Longitude'
    expect(page).to have_button 'Finalizar'
    expect(page).to have_button 'Cancelar'
  end
end