require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'user creation' do
      it 'with success' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                      email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                      billing_adress: 'Rua do Seu Carlos, 86', active: true)

        sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
                                      email_domain:"meirelesfrete.com.br", cnpj: "56.522.523/0001-52",
                                      billing_adress: 'Rua do Seu Meireles, 56', active: true)                                        

        u = User.new(name:'Cíço', email:'cícero_medusa@seucarlosfrete.com.br', password:'password')
        u2 = User.new(name:'Malaquias', email:'malaquias_45@meirelesfrete.com.br', password:'password')

        r = u.valid?
        r2 = u2.valid?

        expect(r).to eq true
        expect(r2).to eq true
      end

      it 'with different e-mail domain' do
        sc = ShippingCompany.create!(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                                      email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                                      billing_adress: 'Rua do Seu Carlos, 86', active: true)

        sc2 = ShippingCompany.create!(name:"Frete do Seu Meireles", corporate_name:"FRETE DO SEU MEIRELES LTDA",
                                      email_domain:"meirelesfrete.com.br", cnpj: "56.522.523/0001-52",
                                      billing_adress: 'Rua do Seu Meireles, 56', active: true)                                        

        u = User.new(name:'Cíço', email:'cícero_medusa@outrofrete.com.br', password:'password')
        u2 = User.new(name:'Malaquias', email:'malaquias_45@2outrofrete.com.br', password:'password')

        r = u.valid?
        r2 = u2.valid?

        expect(r).to eq false
        expect(r2).to eq false
      end
    end
  end
end
