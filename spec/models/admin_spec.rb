require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid?' do
    context 'e-mail domain' do
      it 'is not @sistemadefrete.com.br' do
        a = Admin.new(name: 'Fred', email: 'frederico_marmelo@domínioerrado.com.br',
                      password: 'password')
        r = a.valid?

        expect(r).to eq false
      end

      it 'is @sistemadefrete.com.br' do
        a = Admin.new(name: 'Fred', email: 'frederico_marmelo@sistemadefrete.com.br',
                      password: 'password')
        r = a.valid?

        expect(r).to eq true
      end
    end
    oasvev
  end
end
