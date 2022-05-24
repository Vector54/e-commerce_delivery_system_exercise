require 'rails_helper'

describe 'Admin acessa index de transportadoras' do
  it ', clica numa transportadora e vê seus detalhes' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
        email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
        billing_adress: 'Rua do Seu Carlos, 86', active: true)

    sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
          email_domain:"meirelesfrete.com.br", cnpj: "56.522.523/0001-52",
          billing_adress: 'Rua do Seu Meireles, 56', active: false) 

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Transportadoras Cadastradas'
    click_on 'Frete do Seu Meireles'

    expect(page).to have_content sc2.name
    expect(page).to have_content "Razão social: #{sc2.corporate_name}"
    expect(page).to have_content "CNPJ: #{sc2.cnpj}"
    expect(page).to have_content "Endereço para faturamento: #{sc2.billing_adress}"
    expect(page).to have_content 'Está inativa'
    expect(page).to have_content "Domínio de e-mail: #{sc2.email_domain}"
  end

  it 'E não vê transortadoras' do
    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Transportadoras Cadastradas'

    expect(page).to have_content "Não há transportadoras cadastradas."
  end
end