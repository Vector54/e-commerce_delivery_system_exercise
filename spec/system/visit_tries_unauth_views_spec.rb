require 'rails_helper'

describe 'Visitante é barrado quando tenta acessar tela de' do
  it 'consulta de preço' do
    visit budget_query_shipping_companies_path

    expect(current_path).not_to be budget_query_shipping_companies_path
  end

  it 'index de transportadoras' do
    visit shipping_companies_path

    expect(current_path).to eq new_admin_session_path
  end

  it 'cadastro de transportadoras' do
    visit new_shipping_company_path

    expect(current_path).to eq new_admin_session_path
  end

  it 'show de transportadoras' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_path(sc.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'OSs de uma transportadora' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_order_index_path(sc.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'veículos de uma transportadora' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_vehicles_path(sc.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'preços de uma transportadora' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_price_table_index_path(sc.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'prazos de uma transportadora' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    visit shipping_company_delivery_time_table_index_path(sc.id)

    expect(current_path).to eq new_user_session_path
  end
end