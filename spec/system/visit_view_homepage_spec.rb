require 'rails_helper'

describe 'Visitante acessa a tela inicial' do
  it 'e a vê' do
    visit root_path

    expect(page).to have_content 'Sistema de frete'
    expect(page).to have_content 'Bem vindo'
    expect(page).to have_link 'Admin'
    expect(page).to have_link 'Usuário'
    expect(page).to have_field 'Consulta de OS'
    expect(page).to have_button 'Pesquisar'
  end

  it 'e acessa a pagina de sign-in do Admin' do
    visit root_path
    click_on 'Admin'

    expect(page).to have_field "E-mail"
    expect(page).to have_field "Senha"
  end

  it 'e acessa a pagina de sign in do Usuário' do
    visit root_path
    click_on 'Usuário'

    expect(page).to have_field "E-mail"
    expect(page).to have_field "Senha"
  end

  it 'e faz uma busca' do
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

    ul = UpdateLine.create!(coordinates: '145, 64', order: os)                  

    visit root_path
    fill_in 'Consulta de OS', with: os.code
    click_on 'Pesquisar'

    expect(page).to have_content os.code
    expect(page).to have_content ul.coordinates
  end

  it 'e faz uma busca errada' do
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

    ul = UpdateLine.create!(coordinates: '14, 564', order: os)                  

    visit root_path
    fill_in 'Consulta de OS', with: 'notavalidcode'
    click_on 'Pesquisar'

    expect(page).to have_content 'Nenhum resultado para a pesquisa.'
  end
end