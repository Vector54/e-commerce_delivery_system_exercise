require 'rails_helper'

describe 'Usuário acessa link para registrar nova linha da tabela de prazo' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)
    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save
          
    login_as u
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Linha'
    
    expect(page).to have_field 'Distância'
    expect(page).to have_field 'a'
    expect(page).to have_field 'Prazo'
  end

  it 'e cadastra uma linha' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)
    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save
          
    login_as u
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Linha'
    fill_in 'Distância', with: '0'
    fill_in 'a', with: '100'
    fill_in 'Prazo', with: '2'
    click_on 'Cadastrar'
    
    dtl = DeliveryTimeLine.last
    expect(page).to have_content "#{dtl.init_distance} - #{dtl.final_distance}"
    expect(page).to have_content "#{dtl.delivery_time}"
  end

  it 'e falha ao cadastrar uma linha' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)
    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save
          
    login_as u
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Linha'
    fill_in 'Distância', with: '0'
    click_on 'Cadastrar'
    
    expect(page).to have_content "Cadastro Falhou"
  end
end