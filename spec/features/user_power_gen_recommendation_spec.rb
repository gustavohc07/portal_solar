require 'rails_helper'

describe 'User receive power generator recommendation' do
  scenario 'successfully', js: true do
    power_gen1 = FactoryBot.create(:power_generator, name: 'Trifasico',
                                                     price: 30_000.0,
                                                     structure_type: :ceramico)
    power_gen2 = FactoryBot.create(:power_generator, name: 'Bifasico',
                                                     price: 70_000.0,
                                                     structure_type: :metalico)
    visit root_path

    choose 'Pesquisa Avançada'
    fill_in 'Capital Disponivel', with: 50_000.0
    select 'WEG', from: 'Fabricante'
    select 'Ceramico', from: 'Estrutura de Fixacao para o Painel Solar'
    click_on 'Ver Recomendacoes'

    expect(page).to have_content('Trifasico')
    expect(page).to have_content('R$ 30.000,00')
  end

  xscenario 'test' do

    within 'div.advanced-form' do
    end

    expect(page).to have_content('Suas recomendacoes')
    expect(page).to have_content('Suas recomendacoes')
    expect(page).to have_content('Suas recomendacoes')
  end
end
