require 'rails_helper'

describe 'Admin loga' do
	it 'e vê links de navegação' do
		a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
		a.confirm
		a.save

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'

		expect(page).to have_link 'Transportadoras Cadastradas'
		expect(page).to have_link 'Cadastrar Transportadora'
		expect(page).to have_link 'Consulta de Preço'
		expect(page).to have_button 'Sair'
		expect(page).not_to have_content 'Bem vindo!'
	end
end