require 'rails_helper' 

describe 'Usuário é barrado quando tenta acessar tela' do
  it 'de cadastro de transportadora' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
		u.confirm
		u.save

    login_as u
    visit new_shipping_company_path

    expect(current_path).to eq new_admin_session_path
  end

  it 'de cadastro de OS' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
		u.confirm
		u.save

    login_as u
    visit new_shipping_company_order_path(sc.id)

    expect(current_path).to eq new_admin_session_path
  end

  it 'de index de transportadoras' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
		u.confirm
		u.save

    login_as u
    visit shipping_companies_path

    expect(current_path).to eq new_admin_session_path
  end

  it 'de consulta de preço' do
    sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                billing_adress: 'Rua do Seu Carlos, 86', active: true)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
		u.confirm
		u.save

    login_as u
    visit budget_query_shipping_companies_path

    expect(current_path).to eq new_admin_session_path
  end
end