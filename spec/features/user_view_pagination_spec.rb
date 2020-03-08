require 'rails_helper'

describe 'User view pagination' do
  scenario 'successfully view only 6 generators' do
    power_gen1 = create(:power_generator, name: 'Trifasico')
    power_gen2 = create(:power_generator, name: 'Bifasico')
    power_gen3 = create(:power_generator, name: 'Monofasico')
    power_gen4 = create(:power_generator, name: 'Poli half cell')
    power_gen5 = create(:power_generator, name: 'Hibrido')
    power_gen6 = create(:power_generator, name: 'Cells mono perc')
    power_gen7 = create(:power_generator, name: 'WEG')

    visit root_path

    expect(page).to have_content(power_gen1.name.upcase)
    expect(page).to have_content(power_gen2.name.upcase)
    expect(page).to have_content(power_gen3.name.upcase)
    expect(page).to have_content(power_gen4.name.upcase)
    expect(page).to have_content(power_gen5.name.upcase)
    expect(page).to have_content(power_gen6.name.upcase)
    expect(page).not_to have_content(power_gen7.name.upcase)
  end

  scenario 'and can go to next page and view generators' do
    power_gen1 = create(:power_generator, name: 'Trifasico')
    power_gen2 = create(:power_generator, name: 'Bifasico')
    power_gen3 = create(:power_generator, name: 'Monofasico')
    power_gen4 = create(:power_generator, name: 'Poli half cell')
    power_gen5 = create(:power_generator, name: 'Hibrido')
    power_gen6 = create(:power_generator, name: 'Cells mono perc')
    power_gen7 = create(:power_generator, name: 'WEG')

    visit root_path
    click_on 'Next'

    expect(page).to have_content(power_gen7.name.upcase)
    expect(page).not_to have_content(power_gen1.name.upcase)
    expect(page).not_to have_content(power_gen2.name.upcase)
    expect(page).not_to have_content(power_gen3.name.upcase)
    expect(page).not_to have_content(power_gen4.name.upcase)
    expect(page).not_to have_content(power_gen5.name.upcase)
    expect(page).not_to have_content(power_gen6.name.upcase)
  end
end
