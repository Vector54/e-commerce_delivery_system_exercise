# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid?' do
    context 'when e-mail domain' do
      it 'is not @sistemadefrete.com.br, should give false' do
        a = described_class.new(name: 'Fred', email: 'frederico_marmelo@domínioerrado.com.br', password: 'password')
        r = a.valid?

        expect(r).to be false
      end

      it 'is @sistemadefrete.com.br, should give true' do
        a = described_class.new(name: 'Fred', email: 'frederico_marmelo@sistemadefrete.com.br', password: 'password')
        r = a.valid?

        expect(r).to be true
      end
    end
  end
end
