require 'rails_helper'

describe 'Usuário acessa link "Minha Transportadora"' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Minha Transportadora'

    expect(page).to have_content sc.name
    expect(page).to have_content "Razão social: #{sc.corporate_name}"
    expect(page).to have_content "CNPJ: #{sc.cnpj}"
    expect(page).to have_content "Endereço para faturamento: #{sc.billing_adress}"
    expect(page).to have_content 'Está ativa'
    expect(page).to have_content "Domínio de e-mail: #{sc.email_domain}"
    expect(page).not_to have_link 'Editar'
    expect(page).to have_link 'Ordens de Serviço', count: 1
  end
end