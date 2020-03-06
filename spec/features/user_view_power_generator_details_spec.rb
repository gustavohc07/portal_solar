require 'rails_helper'

describe 'User view power generator details' do
  scenario 'successfully' do
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

    expect(page).to have_content('TRIFASICO')
    expect(page).to have_content('R$ 30.000,00')
    expect(page).to have_content('Modelo residencial')
    expect(page).to have_content('WEG')
    expect(page).to have_content('1.27 kwp')
    expect(page).to have_content('1.0 metro')
    expect(page).to have_content('0.3 metros')
    expect(page).to have_content('1.5 metros')
    expect(page).to have_content('90.0 kg')
    expect(page).to have_content('Laje')
  end

  scenario 'and can go back to list of generators' do
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
    click_on 'Ver todos'

    expect(current_path).to eq power_generators_path
  end
end
