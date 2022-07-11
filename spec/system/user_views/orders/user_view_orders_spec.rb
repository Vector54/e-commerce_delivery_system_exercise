# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário acessa index de OSs' do
  it 'e as vê' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, 
                                   delivery_time: 2, shipping_company: sc)

    pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5,
                           maximum_weight: 50, value: 100, shipping_company: sc)

    os = Order.create!(admin: a, weight: 10,
                       shipping_company: sc, distance: 95, pickup_adress: 'Rua de Retirada, 45',
                       product_code: 'SOMTHIN-098', width: 1, height: 2, depth: 2,
                       delivery_adress: 'Rua de Entrega, 54', cpf: '568.568.568-86')

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Ordens de Serviço'

    expect(page).to have_content os.code.to_s
    expect(page).to have_content " - #{os.status}"
    expect(page).not_to have_link 'Cadastrar OS'
  end
end
