require 'rails_helper'

describe 'Usuário acessa tela de registro de veículo' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'

    expect(page).to have_field 'Placa'
    expect(page).to have_field 'Marca e Modelo'
    expect(page).to have_field 'Ano de Fabricação'
    expect(page).to have_field 'Carga Máxima'
    expect(page).to have_button 'Cadastrar'
  end

  it 'e cadastra um veículo' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Placa', with: '8585-POU'
    fill_in 'Marca e Modelo', with: 'Volksvagem - Delivery 9.170'
    fill_in 'Ano de Fabricação', with: '2022'
    fill_in 'Carga Máxima', with: '8800000'
    click_on 'Cadastrar'

                                        
    v = Vehicle.last
    expect(page).to have_content 'Cadastro realizado com sucesso.'                             
    expect(page).to have_content v.brand_model
    expect(page).to have_content "Placa -"
    expect(page).to have_link v.plate
  end

  it 'e falha ao cadastrar um veículo' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Placa', with: '8585-POU'
    click_on 'Cadastrar'

                                        
    expect(page).to have_content 'Cadastro falhou.'                             
  end
end