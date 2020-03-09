require 'rails_helper'

describe 'User view freight cost to his state' do
  scenario 'successfully' do
    create(:freight, state: 'MG',
                     weight_min: 81,
                     weight_max: 90,
                     cost: 667.58)
    create(:power_generator, name: 'Trifasico',
                             price: 30_000,
                             description: 'Modelo residencial',
                             image_url: 'https://go.aws/2Tq8svj',
                             manufacturer: 'WEG',
                             kwp: 1.27,
                             height: 1,
                             width: 0.3,
                             lenght: 1.5,
                             weight: 90,
                             structure_type: :laje)

    visit root_path
    click_on 'TRIFASICO'
    fill_in 'CEP', with: '38408200'
    click_on 'Calcular Frete'

    expect(page).to have_content('Estado: MG')
    expect(page).to have_content('Custo do frete: R$ 667,58')
  end

  scenario 'and enter invalid CEP' do
    create(:freight, state: 'MG',
                     weight_min: 81,
                     weight_max: 90,
                     cost: 667.58)
    create(:power_generator, name: 'Trifasico',
                             price: 30_000,
                             description: 'Modelo residencial',
                             image_url: 'https://go.aws/2Tq8svj',
                             manufacturer: 'WEG',
                             kwp: 1.27,
                             height: 1,
                             width: 0.3,
                             lenght: 1.5,
                             weight: 90,
                             structure_type: :laje)

    visit root_path
    click_on 'TRIFASICO'
    fill_in 'CEP', with: '99999999'
    click_on 'Calcular Frete'

    expect(page).to have_content('CEP inválido.')
  end

  scenario 'and do not enter a CEP at all' do
    create(:freight, state: 'MG',
                     weight_min: 81,
                     weight_max: 90,
                     cost: 667.58)
    create(:power_generator, name: 'Trifasico',
                             price: 30_000,
                             description: 'Modelo residencial',
                             image_url: 'https://go.aws/2Tq8svj',
                             manufacturer: 'WEG',
                             kwp: 1.27,
                             height: 1,
                             width: 0.3,
                             lenght: 1.5,
                             weight: 90,
                             structure_type: :laje)

    visit root_path
    click_on 'TRIFASICO'
    click_on 'Calcular Frete'

    expect(page).to have_content('CEP inválido.')
  end
end
