# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
  describe '#valid?' do
    context 'when presence' do
      it 'of everything should give true' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?

        expect(r).to be true
      end

      it 'of everything but name should give false' do
        sc = described_class.new(name: '', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?

        expect(r).to be false
      end

      it 'of everything but corporate name should give false' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: '',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?

        expect(r).to be false
      end

      it 'of everything but email domain should give false' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: '', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?

        expect(r).to be false
      end

      it 'of everything but cnpj should give false' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?

        expect(r).to be false
      end

      it 'of everything but billing adress should give false' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: '', active: true)
        r = sc.valid?

        expect(r).to be false
      end

      it 'of everything but active should give false' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: '')
        r = sc.valid?

        expect(r).to be true
      end
    end

    context 'when format' do
      it 'of CNPJ and email are valid' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

        r = sc.valid?

        expect(r).to be true
      end

      it 'of CNPJ is invalid for different amount of characters' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

        r = sc.valid?

        expect(r).to be false
      end

      it 'of email domain is invalid for having a @' do
        sc = described_class.new(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: '@seucarlosfretecom.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

        r = sc.valid?

        expect(r).to be false
      end
    end
  end
end
