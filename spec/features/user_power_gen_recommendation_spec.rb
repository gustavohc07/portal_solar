require 'rails_helper'

describe 'User receive power generator recommendation' do
  context 'with all or some field informed' do
    scenario 'and is successful informing 3 params', js: true do
      FactoryBot.create(:power_generator, name: 'Trifasico',
                                          price: 30_000.0,
                                          structure_type: :ceramico,
                                          manufacturer: 'WEG')
      FactoryBot.create(:power_generator, name: 'Bifasico',
                                          price: 70_000.0,
                                          structure_type: :metalico,
                                          manufacturer: 'WEG')

      visit root_path

      choose 'Pesquisa Avançada'
      fill_in 'Capital Disponível', with: 50_000.0
      select 'WEG', from: 'Fabricante'
      select 'ceramico', from: 'Estrutura de Fixação para o Painel Solar'
      click_on 'Ver Recomendações'

      expect(page).to have_content('TRIFASICO')
      expect(page).to have_content('R$ 30.000,00')
      expect(page).not_to have_content('BIFASICO')
      expect(page).not_to have_content('R$ 70.000,00')
    end

    scenario 'and is successful informing 2 params', js: true do
      FactoryBot.create(:power_generator, name: 'Trifasico',
                                          price: 30_000.0,
                                          structure_type: :ceramico,
                                          manufacturer: 'WEG')
      FactoryBot.create(:power_generator, name: 'Bifasico',
                                          price: 70_000.0,
                                          structure_type: :metalico,
                                          manufacturer: 'WEG')

      visit root_path

      choose 'Pesquisa Avançada'
      select 'WEG', from: 'Fabricante'
      select 'ceramico', from: 'Estrutura de Fixação para o Painel Solar'
      click_on 'Ver Recomendações'

      expect(page).to have_content('TRIFASICO')
      expect(page).to have_content('R$ 30.000,00')
      expect(page).not_to have_content('BIFASICO')
      expect(page).not_to have_content('R$ 70.000,00')
    end
    scenario 'and is successful informing 1 param', js: true do
      FactoryBot.create(:power_generator, name: 'Trifasico',
                                          price: 30_000.0,
                                          structure_type: :ceramico,
                                          manufacturer: 'WEG')
      FactoryBot.create(:power_generator, name: 'Bifasico',
                                          price: 70_000.0,
                                          structure_type: :metalico,
                                          manufacturer: 'WEG')

      visit root_path

      choose 'Pesquisa Avançada'
      select 'ceramico', from: 'Estrutura de Fixação para o Painel Solar'
      click_on 'Ver Recomendações'

      expect(page).to have_content('TRIFASICO')
      expect(page).to have_content('R$ 30.000,00')
      expect(page).not_to have_content('BIFASICO')
      expect(page).not_to have_content('R$ 70.000,00')
    end

    scenario 'and is able to see all panels again', js: true do
      FactoryBot.create(:power_generator, name: 'Trifasico',
                                          price: 30_000.0,
                                          structure_type: :ceramico,
                                          manufacturer: 'WEG')
      FactoryBot.create(:power_generator, name: 'Bifasico',
                                          price: 70_000.0,
                                          structure_type: :metalico,
                                          manufacturer: 'WEG')

      visit root_path

      choose 'Pesquisa Avançada'
      fill_in 'Capital Disponível', with: 50_000.0
      select 'WEG', from: 'Fabricante'
      select 'ceramico', from: 'Estrutura de Fixação para o Painel Solar'
      click_on 'Ver Recomendações'
      click_on 'Ver todos'

      expect(page).to have_content('TRIFASICO')
      expect(page).to have_content('R$ 30.000,00')
      expect(page).to have_content('BIFASICO')
      expect(page).to have_content('R$ 70.000,00')
    end

    scenario 'and return a flash message if there are no matches', js: true do
      FactoryBot.create(:power_generator, name: 'Trifasico',
                                          price: 30_000.0,
                                          structure_type: :ceramico,
                                          manufacturer: 'WEG')
      FactoryBot.create(:power_generator, name: 'Bifasico',
                                          price: 70_000.0,
                                          structure_type: :metalico,
                                          manufacturer: 'WEG')

      visit root_path

      choose 'Pesquisa Avançada'
      fill_in 'Capital Disponível', with: 10_000.0
      select 'WEG', from: 'Fabricante'
      select 'ceramico', from: 'Estrutura de Fixação para o Painel Solar'
      click_on 'Ver Recomendações'

      expect(page).to have_content('Infelizmente não há correspondentes.')
    end
  end
end
