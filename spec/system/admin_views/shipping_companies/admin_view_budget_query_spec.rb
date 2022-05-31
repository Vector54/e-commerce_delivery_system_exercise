require 'rails_helper'

describe 'Admin acessa página de consulta' do
  it 'e a vê' do
    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
		a.confirm
		a.save

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Consulta de Preço'

    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Profundidade'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Distância'
    expect(page).to have_button 'Consultar'
  end

  it 'e faz uma consulta com sucesso' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)
    sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
                                    email_domain:"seumeirelesfrete.com.br", cnpj: "06.902.578/0001-57",
                                    billing_adress: 'Rua do Seu Meireles, 68', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    dtl1_1 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 2, 
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl1_1 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
                           maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

    dtl2_1 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 4, 
                           delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl2_1 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
                   maximum_weight: 70, value: 150, price_table: PriceTable.find_by(shipping_company: sc))

    dtl1_2 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 3, 
                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

    pl1_2 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
           maximum_weight: 50, value: 50, price_table: PriceTable.find_by(shipping_company: sc2))

    dtl2_2 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 6, 
           delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

    pl2_2 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
            maximum_weight: 70, value: 100, price_table: PriceTable.find_by(shipping_company: sc2))                                      

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Consulta de Preço'
    fill_in 'Largura', with: 2
    fill_in 'Altura', with: 2
    fill_in 'Profundidade', with: 2
    fill_in 'Peso', with: 10
    fill_in 'Distância', with: 75
    click_on 'Consultar'

    expect(page).to have_link sc.name
    expect(page).to have_content 'R$75,00'
    expect(page).to have_content '4 dias'
    expect(page).to have_link sc2.name
    expect(page).to have_content 'R$37,50'
    expect(page).to have_content '6 dias'
  end

  it 'e faz uma consulta sem sucesso' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)
    sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
                                    email_domain:"seumeirelesfrete.com.br", cnpj: "06.902.578/0001-57",
                                    billing_adress: 'Rua do Seu Meireles, 68', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    dtl1_1 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 2, 
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl1_1 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
                           maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

    dtl2_1 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 4, 
                           delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl2_1 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
                   maximum_weight: 70, value: 150, price_table: PriceTable.find_by(shipping_company: sc))

    dtl1_2 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 3, 
                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

    pl1_2 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
           maximum_weight: 50, value: 50, price_table: PriceTable.find_by(shipping_company: sc2))

    dtl2_2 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 6, 
           delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

    pl2_2 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
            maximum_weight: 70, value: 100, price_table: PriceTable.find_by(shipping_company: sc2))                                      

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Consulta de Preço'
    fill_in 'Largura', with: 1000
    fill_in 'Altura', with: 1000
    fill_in 'Profundidade', with: 1000
    fill_in 'Peso', with: 1000
    fill_in 'Distância', with: 1000
    click_on 'Consultar'

    expect(page).to have_content 'Nenhum resultado encontrado.'
  end

  it 'e faz uma consulta de empresas inativas' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86')
    sc.update({"active"=>"false"})
    sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
                                    email_domain:"seumeirelesfrete.com.br", cnpj: "06.902.578/0001-57",
                                    billing_adress: 'Rua do Seu Meireles, 68', active: true)
    sc2.update({"active"=>"false"})
    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    dtl1_1 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 2, 
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl1_1 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
                           maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

    dtl2_1 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 4, 
                           delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl2_1 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
                   maximum_weight: 70, value: 150, price_table: PriceTable.find_by(shipping_company: sc))

    dtl1_2 = DeliveryTimeLine.create!(init_distance: 1, final_distance: 50, delivery_time: 3, 
                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

    pl1_2 = PriceLine.create!(minimum_volume: 1, maximum_volume: 50, minimum_weight: 5, 
           maximum_weight: 50, value: 50, price_table: PriceTable.find_by(shipping_company: sc2))

    dtl2_2 = DeliveryTimeLine.create!(init_distance: 51, final_distance: 100, delivery_time: 6, 
           delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc2))

    pl2_2 = PriceLine.create!(minimum_volume: 51, maximum_volume: 100, minimum_weight: 51, 
            maximum_weight: 70, value: 100, price_table: PriceTable.find_by(shipping_company: sc2))                                      

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Consulta de Preço'
    fill_in 'Largura', with: 2
    fill_in 'Altura', with: 2
    fill_in 'Profundidade', with: 2
    fill_in 'Peso', with: 10
    fill_in 'Distância', with: 75
    click_on 'Consultar'

    expect(page).to have_content 'Nenhum resultado encontrado.'
  end

  it 'e faz uma consulta com resultado de valor mínimo' do
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

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Consulta de Preço'
    fill_in 'Largura', with: 1
    fill_in 'Altura', with: 1
    fill_in 'Profundidade', with: 1
    fill_in 'Peso', with: 10
    fill_in 'Distância', with: 75
    click_on 'Consultar'

    expect(page).to have_link sc.name
    expect(page).to have_content 'R$18,75'
    expect(page).to have_content '4 dias'
    expect(page).to have_link sc2.name
    expect(page).to have_content 'R$18,75'
    expect(page).to have_content '6 dias'
  end
end