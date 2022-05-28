require 'rails_helper'

describe 'Admin acessa tela de cadastro de OS' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
		a.confirm
		a.save

		visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Transportadoras Cadastradas'
    click_on 'Frete do Seu Carlos'
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar OS'

    expect(page).to have_field 'Endereço para retirada'
    expect(page).to have_field 'Código do produto'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Profundidade'
    expect(page).to have_field 'Endereço para entrega'
    expect(page).to have_field 'CPF do destinatário'
    expect(page).to have_field 'Distância total'
    expect(page).to have_button 'Cadastrar'
  end

  it 'e cadastra uma' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    a = Admin.new(email: 'teste@sistemadefrete.com.br', password: 'password456')
		a.confirm
		a.save

    dtl = DeliveryTimeLine.create!(init_distance: 10, final_distance: 100, delivery_time: 2, 
                                  delivery_time_table: DeliveryTimeTable.find_by(shipping_company: sc))

    pl = PriceLine.create!(minimum_volume: 1, maximum_volume: 5000, minimum_weight: 5, 
                          maximum_weight: 50, value: 150, price_table: PriceTable.find_by(shipping_company: sc))                                    


		visit root_path
    click_on 'Admin'
		fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
		fill_in 'Senha', with: 'password456'
		click_on 'Log in'
    click_on 'Transportadoras Cadastradas'
    click_on 'Frete do Seu Carlos'
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar OS'
    fill_in 'Endereço para retirada', with: 'Rua de Retirada, 45'
    fill_in 'Código do produto', with: 'SOMTHIN-098'
    fill_in 'Largura', with: '1'
    fill_in 'Altura', with: '2'
    fill_in 'Profundidade', with: '2'
    fill_in 'Peso', with: '10'
    fill_in 'Endereço para entrega', with: 'Rua de Entrega, 54'
    fill_in 'CPF do destinatário', with: '568.568.568-86'
    fill_in 'Distância total', with: '95'
    click_on 'Cadastrar'

    os = Order.last
    expect(os.code).not_to be_empty
    expect(page).to have_content os.code
    expect(page).to have_content "Transportadora - #{os.shipping_company.name}"
    expect(page).to have_content "Distância Km - #{os.distance}"
    expect(page).to have_content "Orçamento - R$142,50"
    expect(page).to have_content "Data de entrega - #{os.date}"
    expect(page).to have_content "Código do produto - #{os.product_code}"
    expect(page).to have_content "Volume m³ - #{os.width*os.height*os.depth}"
    expect(page).to have_content "Peso Kg - #{os.weight}"
    expect(page).to have_content "Endereço de retirada - #{os.pickup_adress}"
    expect(page).to have_content "Endereço de entrega - #{os.delivery_adress}"
    expect(page).to have_content "CPF do destinatário - #{os.cpf}"
    expect(page).to have_content "Status - #{os.status}"
  end
end