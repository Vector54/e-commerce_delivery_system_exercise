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
	
	it 'e acessa lista de transportadoras' do
		sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
																	email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
																	billing_adress: 'Rua do Seu Carlos, 86', active: true)

		sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
																	email_domain:"meirelesfrete.com.br", cnpj: "56.522.523/0001-52",
																	billing_adress: 'Rua do Seu Meireles, 56', active: true) 

		a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
		a.confirm
		a.save

		visit root_path
		click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
		click_on 'Transportadoras Cadastradas'

		expect(page).to have_link 'Frete do Seu Carlos'
		expect(page).to have_link 'Frete do Seu Meireles'
	end
end