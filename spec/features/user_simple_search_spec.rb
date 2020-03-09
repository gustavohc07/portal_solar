require 'rails_helper'

describe 'User uses simple search' do
  scenario 'and returns power generators successfully', js: true do
    FactoryBot.create(:power_generator, name: 'Trifasico',
                                        price: 30_000.0,
                                        description: 'Primeiro Gerador',
                                        manufacturer: 'WEG')
    FactoryBot.create(:power_generator, name: 'Bifasico',
                                        price: 70_000.0,
                                        description: 'Segundo Gerador',
                                        manufacturer: 'Q cells')

    visit root_path
    fill_in :q, with: 'primeiro'
    click_on 'Procurar'

    expect(page).to have_content('TRIFASICO')
  end

  scenario 'and returns a message if no generators found', js: true do
    FactoryBot.create(:power_generator, name: 'Trifasico',
                                        price: 30_000.0,
                                        description: 'Primeiro Gerador',
                                        manufacturer: 'WEG')

    visit root_path
    fill_in :q, with: 'Segundo'
    click_on 'Procurar'

    expect(page).to have_content('Não encontramos correspondentes.')
  end
end
