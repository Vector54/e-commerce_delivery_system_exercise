# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'gives true when e-mail is of existing company' do
      sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                   email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                   billing_adress: 'Rua do Seu Carlos, 86', active: true)

      u = described_class.new(name: 'Cícero', email: 'cícero-email@seucarlosfrete.com.br', password: 'password')

      r = u.valid?

      expect(r).to be true
    end

    it 'gives false when e-mail is of a non existing company' do
      sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                   email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                   billing_adress: 'Rua do Seu Carlos, 86', active: true)

      u = described_class.new(name: 'Cícero', email: 'cícero-email@outrofrete.com.br', password: 'password')

      r = u.valid?

      expect(r).to be false
    end
  end
end
