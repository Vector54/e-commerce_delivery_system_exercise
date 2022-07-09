# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário acessa tela de atualização de veículo' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86')

    sc2 = ShippingCompany.create!(name: 'Frete do Seu Meireles', corporate_name: 'FRETE DO SEU MEIRELES LTDA',
                                  email_domain: 'seumeirelesfrete.com.br', cnpj: '06.905.995/0001-62',
                                  billing_adress: 'Rua do Seu Meireles, 75')

    v = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                        weight_capacity: 8_800_000, shipping_company: sc)

    v2 = Vehicle.create!(plate: '8575-POU', brand_model: 'Scania - Grosner', year: '2022',
                         weight_capacity: 8_800_000, shipping_company: sc2)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    click_on v.plate
    click_on 'Editar'

    expect(page).to have_field 'Placa', with: v.plate
    expect(page).to have_field 'Marca e Modelo', with: v.brand_model
    expect(page).to have_field 'Ano de Fabricação', with: v.year
    expect(page).to have_field 'Carga Máxima', with: v.weight_capacity
    expect(page).to have_button 'Atualizar Veículo'
  end

  it 'e atualiza um veículo com sucesso' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86')

    v = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                        weight_capacity: 8800, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    click_on v.plate
    click_on 'Editar'
    fill_in 'Placa', with: '6565-LKO'
    fill_in 'Carga Máxima', with: '7500'
    click_on 'Atualizar Veículo'

    expect(page).to have_content '6565-LKO'
    expect(page).to have_content "Marca e Modelo - #{v.brand_model}"
    expect(page).to have_content "Ano - #{v.year}"
    expect(page).to have_content 'Capacidade de carga Kg - 7500'
    expect(page).to have_content 'Veículo atualizado com sucesso.'
  end

  it 'e não atualiza um veículo com sucesso' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86')

    v = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                        weight_capacity: 8800, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    click_on v.plate
    click_on 'Editar'
    fill_in 'Placa', with: ''
    fill_in 'Carga Máxima', with: '7500'
    click_on 'Atualizar Veículo'

    expect(page).to have_content 'Atualização falhou.'
  end
end
