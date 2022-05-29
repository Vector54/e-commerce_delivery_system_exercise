require 'rails_helper'

describe 'Admin acessa página de cadastro de transportadora' do
  it 'e vê os campos' do
    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Cadastrar Transportadora'
    
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço para faturamento'
    expect(page).to have_field 'Domínio de e-mail'
    expect(page).to have_button 'Criar Transportadora'
  end

  it 'e cadastra uma nova transportadora' do
    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Cadastrar Transportadora'
    fill_in 'Nome', with: 'Frete do Seu Carlos'
    fill_in 'Razão social', with: 'FRETE DO SEU CARLOS LTDA'
    fill_in 'CNPJ', with: '06.902.995/0001-62'
    fill_in 'Endereço para faturamento', with: 'Rua do Seu Carlos, 56'
    fill_in 'Domínio de e-mail', with: 'seucarlosfrete.com.br'
    click_on 'Criar Transportadora'

    sc = ShippingCompany.last
    expect(page).to have_content 'Cadastro realizado com sucesso.'
    expect(page).to have_content sc.name
    expect(page).to have_content "Razão social: #{sc.corporate_name}"
    expect(page).to have_content "CNPJ: #{sc.cnpj}"
    expect(page).to have_content "Endereço para faturamento: #{sc.billing_adress}"
    expect(page).to have_content 'Está ativa'
    expect(page).to have_content "Domínio de e-mail: #{sc.email_domain}"
  end

  it 'e falha ao cadastrar uma nova transportadora' do
    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
    a.confirm
    a.save

    visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Cadastrar Transportadora'
    fill_in 'Nome', with: 'Frete do Seu Carlos'
    click_on 'Criar Transportadora'

    expect(page).to have_content 'Cadastro falhou.'
  end
end