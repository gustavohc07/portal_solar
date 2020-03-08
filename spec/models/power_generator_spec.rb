require 'rails_helper'
# TODO, validations
RSpec.describe PowerGenerator, type: :model do
  it 'is valid with name, description, image, manufacturer, price and kwp' do
    power_gen = FactoryBot.build(:power_generator, name: 'Trifasico',
                                                   description: 'Gerador',
                                                   image_url: 'https://go.aws/2Tq8svj',
                                                   manufacturer: 'WEG',
                                                   price: 49_999.0,
                                                   kwp: 17)

    expect(power_gen).to be_valid
  end

  describe 'search for recommendations' do
    before do
      @power_gen1 = create(:power_generator, price: 10_000.0,
                                             manufacturer: 'WEG',
                                             structure_type: :ceramico)
      @power_gen2 = create(:power_generator, price: 20_000.0,
                                             manufacturer: 'Portal Solar',
                                             structure_type: :metalico)
      @power_gen3 = create(:power_generator, price: 30_000.0,
                                             manufacturer: 'Tesla',
                                             structure_type: :fibrocimento)
      @power_gen4 = create(:power_generator, price: 40_000.0,
                                             manufacturer: 'Portal Solar',
                                             structure_type: :ceramico)
      @power_gen5 = create(:power_generator, price: 50_000.0,
                                             manufacturer: 'WEG',
                                             structure_type: :metalico)
    end
    context 'when a match is found' do
      it 'returns matches with manufacturer, price and structure_type' do
        advice = PowerGenerator.recommendations(20_000, 'WEG', 'ceramico')

        expect(advice).to include(@power_gen1)
        expect(advice).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4, @power_gen5)
      end

      it 'returns matches with manufacturer and price' do
        advice = PowerGenerator.recommendations(50_000, 'WEG', nil)

        expect(advice).to include(@power_gen1, @power_gen5)
        expect(advice).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4)
      end

      it 'returns matches with manufacturer and structure_type' do
        advice = PowerGenerator.recommendations(nil, 'WEG', 'metalico')

        expect(advice).to include(@power_gen5)
        expect(advice).not_to include(@power_gen1, @power_gen2,
                                      @power_gen3, @power_gen4)
      end

      it 'returns matches with price and structure_type' do
        advice = PowerGenerator.recommendations(30_000, nil, 'metalico')

        expect(advice).to include(@power_gen2)
        expect(advice).not_to include(@power_gen1, @power_gen3,
                                      @power_gen4, @power_gen5)
      end

      it 'returns matches with manufacturer' do
        advice = PowerGenerator.recommendations(nil, 'WEG', nil)

        expect(advice).to include(@power_gen1, @power_gen5)
        expect(advice).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4)
      end

      it' returns matches with structure_type' do
        advice = PowerGenerator.recommendations(nil, nil, 'metalico')

        expect(advice).to include(@power_gen2, @power_gen5)
        expect(advice).not_to include(@power_gen1, @power_gen3,
                                      @power_gen4)
      end

      it 'returns within capital limit' do
        advice = PowerGenerator.recommendations(30_000, nil, nil)

        expect(advice).to include(@power_gen1, @power_gen2, @power_gen3)
        expect(advice).not_to include(@power_gen4, @power_gen5)
      end
    end

    context 'when a match is not found' do
      it 'returns empty' do
        expect(PowerGenerator.recommendations(5_000, nil, nil)).to be_empty
      end
    end
  end

  describe 'simple search' do
    before do
      @power_gen1 = create(:power_generator, price: 10_000.0,
                                             manufacturer: 'WEG',
                                             description: 'Primeiro Gerador',
                                             name: 'Monofasico')
      @power_gen2 = create(:power_generator, price: 20_000.0,
                                             manufacturer: 'Portal Solar',
                                             description: 'Segundo Gerador',
                                             name: 'Bifasico')
      @power_gen3 = create(:power_generator, price: 30_000.0,
                                             manufacturer: 'Tesla',
                                             description: 'Terceiro Gerador',
                                             name: 'Hibrido')
      @power_gen4 = create(:power_generator, price: 40_000.0,
                                             manufacturer: 'Q Cells',
                                             description: 'Quarto Gerador',
                                             name: 'Cells Mono Perc')
      @power_gen5 = create(:power_generator, price: 50_000.0,
                                             manufacturer: 'WEG',
                                             description: 'Quinto Gerador',
                                             name: 'Trifasico')
    end

    context 'when a match is found' do
      it 'returns a match' do
        search = PowerGenerator.simple_search('Primeiro')

        expect(search).to include(@power_gen1)
        expect(search).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4, @power_gen5)
      end

      it 'returns more than one match' do
        search = PowerGenerator.simple_search('WEG')

        expect(search).to include(@power_gen1, @power_gen5)
        expect(search).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4)
      end

      it 'returns a match if integer is inputed' do
        search = PowerGenerator.simple_search('10000')

        expect(search).to include(@power_gen1)
        expect(search).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4, @power_gen5)
      end

      it 'is not case sensitive' do
        search = PowerGenerator.simple_search('primeiro')

        expect(search).to include(@power_gen1)
        expect(search).not_to include(@power_gen2, @power_gen3,
                                      @power_gen4, @power_gen5)
      end
    end

    context 'when a match is not found' do
      it 'return empty' do
        search = PowerGenerator.simple_search('Sexto')

        expect(search).to be_empty
      end
    end
  end

  describe 'order by price' do
    it 'returns prices in ascending order' do
      power_gen1 = create(:power_generator, price: 20_000.0,
                                            manufacturer: 'WEG',
                                            structure_type: :ceramico)
      power_gen2 = create(:power_generator, price: 10_000.0,
                                            manufacturer: 'Portal Solar',
                                            structure_type: :metalico)

      expect(PowerGenerator.order(:price).first).to eq(power_gen2)
      expect(PowerGenerator.order(:price).last).to eq(power_gen1)
    end
  end

  describe 'cubic weight' do
    it 'returns cubic weight for a power generator' do
      power_gen1 = create(:power_generator, height: 1.0,
                                            width: 1.0,
                                            lenght: 1.0)

      expect(power_gen1.cubic_weight).to eq(300)
    end
  end
end
