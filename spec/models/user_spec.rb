require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'user creation' do
      it 'with success' do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
              email_domain:"@seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
              billing_adress: 'Rua do Seu Carlos, 86', active: true)

        u = User.new(name:'Cíço', email:'cícero_medusa@seucarlosfrete.com.br', password:'password', shipping_company: sc)

        r = u.valid?

        expect(r).to eq true
      end
    end
  end
end
