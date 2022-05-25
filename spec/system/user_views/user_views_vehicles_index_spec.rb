require 'rails_helper'

describe 'Usuário acessa link de veículos' do
  it 'e vê lista de veículos' do
    v = Vehicle.create!(plate: '8585-POU', brand_model: 'Volksvagem - Delivery 9.170', year: '2022',
                        weight_capacity: 8800000)

    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                  email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                  billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Veículos'
    
    expect(page).to have_content 'Volksvagem - Delivery 9.170'
    expect(page).to have_content 'Placa - 8585-POU'
  end
end