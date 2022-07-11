# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário acessa link de tabela de preço' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    pl = PriceLine.create!(minimum_volume: 100, maximum_volume: 5000, minimum_weight: 10,
                           maximum_weight: 50, value: 100, shipping_company: sc)

    pl2 = PriceLine.create!(minimum_volume: 5001, maximum_volume: 10_000, minimum_weight: 51,
                            maximum_weight: 100, value: 200, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save!

    login_as u
    visit root_path
    click_on 'Tabela de Preços'

    within 'table' do
      expect(page).to have_content 'Volume m³'
      expect(page).to have_content 'Peso Kg'
      expect(page).to have_content 'Preço por Km'
      expect(page).to have_content "#{pl.minimum_volume} - #{pl.maximum_volume}"
      expect(page).to have_content "#{pl.minimum_weight} - #{pl.maximum_weight}"
      expect(page).to have_content 'R$1,00'
      expect(page).to have_content "#{pl2.minimum_volume} - #{pl2.maximum_volume}"
      expect(page).to have_content "#{pl2.minimum_weight} - #{pl2.maximum_weight}"
      expect(page).to have_content 'R$2,00'
    end
    expect(page).to have_content 'Valor mínimo = R$0,00'
  end

  it 'e deleta uma linha' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    pl = PriceLine.create!(minimum_volume: 100, maximum_volume: 5000, minimum_weight: 10,
                           maximum_weight: 50, value: 100, shipping_company: sc)

    pl2 = PriceLine.create!(minimum_volume: 5001, maximum_volume: 10_000, minimum_weight: 51,
                            maximum_weight: 100, value: 200, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save!

    login_as u
    visit root_path
    click_on 'Tabela de Preços'
    within 'table' do
      find('button', match: :first).click
    end

    within 'table' do
      expect(page).to have_content 'Volume m³'
      expect(page).to have_content 'Peso Kg'
      expect(page).to have_content 'Preço por Km'
      expect(page).not_to have_content "#{pl.minimum_volume} - #{pl.maximum_volume}"
      expect(page).not_to have_content "#{pl.minimum_weight} - #{pl.maximum_weight}"
      expect(page).not_to have_content 'R$1,00'
      expect(page).to have_content "#{pl2.minimum_volume} - #{pl2.maximum_volume}"
      expect(page).to have_content "#{pl2.minimum_weight} - #{pl2.maximum_weight}"
      expect(page).to have_content 'R$2,00'
    end
  end

  it 'e muda o preço mínimo' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    pl = PriceLine.create!(minimum_volume: 100, maximum_volume: 5000, minimum_weight: 10,
                           maximum_weight: 50, value: 100, shipping_company: sc)

    pl2 = PriceLine.create!(minimum_volume: 5001, maximum_volume: 10_000, minimum_weight: 51,
                            maximum_weight: 100, value: 200, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save!

    login_as u
    visit root_path
    click_on 'Tabela de Preços'
    fill_in 'Novo preço mínimo', with: '0,25'
    click_on 'Atualizar'

    within 'table' do
      expect(page).to have_content 'Volume m³'
      expect(page).to have_content 'Peso Kg'
      expect(page).to have_content 'Preço por Km'
      expect(page).to have_content "#{pl.minimum_volume} - #{pl.maximum_volume}"
      expect(page).to have_content "#{pl.minimum_weight} - #{pl.maximum_weight}"
      expect(page).to have_content 'R$1,00'
      expect(page).to have_content "#{pl2.minimum_volume} - #{pl2.maximum_volume}"
      expect(page).to have_content "#{pl2.minimum_weight} - #{pl2.maximum_weight}"
      expect(page).to have_content 'R$2,00'
    end
    expect(page).to have_content 'Valor mínimo = R$0,25'
  end
end
