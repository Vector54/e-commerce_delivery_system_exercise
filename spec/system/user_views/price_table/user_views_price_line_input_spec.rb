# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário acessa tela de cadastro de linha da tabela de preço' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save!

    login_as u
    visit root_path
    click_on 'Tabela de Preços'
    click_on 'Cadastrar Linha'

    expect(page).to have_field 'Volume m³'
    expect(page).to have_field 'Peso Kg'
    expect(page).to have_field 'Valor por Km'
  end

  it 'e cadastra uma nova linha' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save!

    login_as u
    visit root_path
    click_on 'Tabela de Preços'
    click_on 'Cadastrar Linha'
    fill_in 'price_line_minimum_volume', with: '100'
    fill_in 'price_line_maximum_volume', with: '10000'
    fill_in 'price_line_minimum_weight', with: '10'
    fill_in 'price_line_maximum_weight', with: '100'
    fill_in 'Valor por Km', with: '50'
    click_on 'Cadastrar'

    expect(page).to have_content '100 - 10000'
    expect(page).to have_content '10 - 100'
    expect(page).to have_content 'R$0,50'
  end

  it 'e falha ao cadastrar uma nova linha' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save!

    login_as u
    visit root_path
    click_on 'Tabela de Preços'
    click_on 'Cadastrar Linha'
    fill_in 'price_line_minimum_volume', with: '100'
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro Falhou'
  end
end
