require 'rails_helper'

describe 'Visitante acessa a tela inicial' do
  it 'e a vê' do
    visit root_path

    expect(page).to have_content 'Sistema de frete'
    expect(page).to have_content 'Bem vindo'
    expect(page).to have_link 'Admin'
    expect(page).to have_link 'Usuário'
    expect(page).to have_field 'Consulta de OS'
    expect(page).to have_button 'Pesquisar'
  end

  it 'e acessa a pagina de sign-in do Admin' do
    visit root_path
    click_on 'Admin'

    expect(page).to have_field "E-mail"
    expect(page).to have_field "Senha"
  end

  it 'e acessa a pagina de sign in do Usuário' do
    visit root_path
    click_on 'Usuário'

    expect(page).to have_field "E-mail"
    expect(page).to have_field "Senha"
  end
end