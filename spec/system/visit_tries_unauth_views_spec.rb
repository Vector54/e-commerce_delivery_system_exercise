# frozen_string_literal: true

require 'rails_helper'

describe 'Visitante é barrado quando tenta acessar tela de' do
  it 'consulta de preço' do
    visit budget_query_shipping_companies_path

    expect(page).not_to have_current_path budget_query_shipping_companies_path
  end

  it 'index de transportadoras' do
    visit shipping_companies_path

    expect(page).to have_current_path new_admin_session_path, ignore_query: true
  end

  it 'cadastro de transportadoras' do
    visit new_shipping_company_path

    expect(page).to have_current_path new_admin_session_path, ignore_query: true
  end

  it 'show de transportadoras' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_path(sc.id)

    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end

  it 'OSs de uma transportadora' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_order_index_path(sc.id)

    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end

  it 'veículos de uma transportadora' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_vehicles_path(sc.id)

    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end

  it 'preços de uma transportadora' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_price_table_index_path(sc.id)

    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end

  it 'prazos de uma transportadora' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_delivery_time_table_index_path(sc.id)

    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end
end
