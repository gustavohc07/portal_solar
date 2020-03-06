require 'rails_helper'

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
end
