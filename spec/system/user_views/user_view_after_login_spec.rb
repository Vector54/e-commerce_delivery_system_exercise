require 'rails_helper'

describe 'Usuário loga' do
  it 'e vê links de navegação' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
		u.confirm
		u.save

    login_as u
    visit root_path
    
    expect(page).to have_link 'Minha Transportadora'
    expect(page).to have_link 'Ordens de Serviço'
    expect(page).to have_link 'Veículos'
    expect(page).to have_link 'Tabela de Preços'
    expect(page).to have_link 'Tabela de Prazos'
    expect(page).to have_button 'Sair'
  end
end