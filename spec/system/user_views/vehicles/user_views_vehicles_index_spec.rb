# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário acessa link de veículos' do
  it 'e vê lista de veículos' do
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

    expect(page).to have_content v.brand_model
    expect(page).to have_content 'Placa -'
    expect(page).to have_link v.plate
    expect(page).not_to have_content v2.brand_model
    expect(page).not_to have_link v2.plate
  end

  it 'e vê detalhes de veículos' do
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

    expect(page).to have_content v.plate
    expect(page).to have_content "Marca e Modelo - #{v.brand_model}"
    expect(page).to have_content "Ano - #{v.year}"
    expect(page).to have_content "Capacidade de carga Kg - #{v.weight_capacity}"
  end

  it 'e deleta um veículo' do
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
    click_on 'Deletar Veículo'

    expect(page).not_to have_content v.plate
    expect(page).not_to have_content "Marca e Modelo - #{v.brand_model}"
    expect(page).not_to have_content "Ano - #{v.year}"
    expect(page).not_to have_content "Capacidade de carga Kg - #{v.weight_capacity}"
  end
end
