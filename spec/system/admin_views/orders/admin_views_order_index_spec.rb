# frozen_string_literal: true

require 'rails_helper'

describe 'Admin acessa index de OSs de uma transportadora' do
  it 'e as vê' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2,
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                           maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

    os = Order.create!(admin: a, code: '456ASD123FGH789', weight: 10,
                       shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')

    visit root_path
    click_on 'Admin'
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password456'
    click_on 'Log in'
    click_on 'Transportadoras Cadastradas'
    click_on 'Frete do Seu Carlos'
    click_on 'Ordens de Serviço'

    expect(page).to have_content os.code.to_s
    expect(page).to have_content " - #{os.status}"
  end

  it 'e acessa os detalhes de uma' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2,
                                   delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                           maximum_weight: 50, value: 100, price_table: PriceTable.find_by(shipping_company: sc))

    os = Order.create!(admin: a, code: '456ASD123FGH789', weight: 10,
                       shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')

    visit root_path
    click_on 'Admin'
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password456'
    click_on 'Log in'
    click_on 'Transportadoras Cadastradas'
    click_on 'Frete do Seu Carlos'
    click_on 'Ordens de Serviço'
    click_on os.code

    expect(page).to have_content os.code
    expect(page).to have_content "Transportadora - #{os.shipping_company.name}"
    expect(page).to have_content "Distância Km - #{os.distance}"
    expect(page).to have_content 'Orçamento - R$95,00'
    expect(page).to have_content "Data de entrega - #{os.date}"
    expect(page).to have_content "Código do produto - #{os.product_code}"
    expect(page).to have_content "Volume m³ - #{os.width * os.height * os.depth}"
    expect(page).to have_content "Peso Kg - #{os.weight}"
    expect(page).to have_content "Endereço de retirada - #{os.pickup_adress}"
    expect(page).to have_content "Endereço de entrega - #{os.delivery_adress}"
    expect(page).to have_content "CPF do destinatário - #{os.cpf}"
    expect(page).to have_content "Admin responsável - #{os.admin.email}"
    expect(page).to have_content "Status - #{os.status}"
    expect(page).not_to have_button 'Aceitar'
    expect(page).not_to have_field 'Veículo'
    expect(page).not_to have_button 'Negar'
  end
end
