# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário acessa tabela de prazos' do
  it 'e a vê' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Tabela de Prazos'

    within 'table' do
      expect(page).to have_content 'Distância Km'
      expect(page).to have_content 'Prazo dias'
      expect(page).to have_content "#{dtl.init_distance} - #{dtl.final_distance}"
      expect(page).to have_content dtl.delivery_time.to_s
    end
  end

  it 'e deleta uma linha' do
    sc = ShippingCompany.create!(name: 'Frete do Seu Carlos', corporate_name: 'FRETE DO SEU CARLOS LTDA',
                                 email_domain: 'seucarlosfrete.com.br', cnpj: '06.902.995/0001-62',
                                 billing_adress: 'Rua do Seu Carlos, 86', active: true)

    dtl = DeliveryTimeLine.create!(init_distance: 0, final_distance: 100, delivery_time: 2, shipping_company: sc)

    u = User.new(name: 'José', email: 'jose@seucarlosfrete.com.br', password: 'password456')
    u.confirm
    u.save

    login_as u
    visit root_path
    click_on 'Tabela de Prazos'
    within 'table' do
      click_on 'Excluir'
    end

    within 'table' do
      expect(page).to have_content 'Distância Km'
      expect(page).to have_content 'Prazo dias'
      expect(page).not_to have_content "#{dtl.init_distance} - #{dtl.final_distance}"
      expect(page).not_to have_content dtl.delivery_time.to_s
    end
  end
end
