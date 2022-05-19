require 'rails_helper'

describe 'Usuário acessa a tela inicial' do
  it 'e a vê' do
    visit root_path

    expect(page).to have_content 'Bem vindo'
    expect(page).to have_link 'Clique aqui para começar'
  end
end