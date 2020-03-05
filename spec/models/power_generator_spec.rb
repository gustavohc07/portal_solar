require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  it 'is valid with name, description, image_url, manufacturer, price and kwp' do
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
      @power_gen1 = FactoryBot.create(:power_generator, price: 10_000.0,
                                                        manufacturer: 'WEG',
                                                        structure_type: :ceramico)
      @power_gen2 = FactoryBot.create(:power_generator, price: 20_000.0,
                                                        manufacturer: 'Portal Solar',
                                                        structure_type: :metalico)
      @power_gen3 = FactoryBot.create(:power_generator, price: 30_000.0,
                                                        manufacturer: 'Tesla',
                                                        structure_type: :fibrocimento)
      @power_gen4 = FactoryBot.create(:power_generator, price: 40_000.0,
                                                        manufacturer: 'Portal Solar',
                                                        structure_type: :ceramico)
      @power_gen5 = FactoryBot.create(:power_generator, price: 50_000.0,
                                                        manufacturer: 'WEG',
                                                        structure_type: :metalico)

    end
    context 'when a match is found' do
      it 'returns power generators that matchs with manufacturer, price and structure_type' do
        expect(PowerGenerator.recommendations(20_000, 'WEG', 'metalico')).to include(@power_gen1, @power_gen2)
        expect(PowerGenerator.recommendations(20_000, 'WEG', 'metalico')).not_to include(@power_gen3, @power_gen4,
                                                                                         @power_gen5)
      end

      it 'returns power generators that matches with manufacturer and price' do
        expect(PowerGenerator.recommendations(50_000, 'WEG', nil)).to include(@power_gen5)
        expect(PowerGenerator.recommendations(50_000, 'WEG', nil)).not_to include(@power_gen1, @power_gen2,
                                                                                  @power_gen3, @power_gen4)
      end

      it 'returns power generators that matches with manufacturer and structure_type' do
        expect(PowerGenerator.recommendations(nil, 'WEG', 'metalico')).to include()
        expect(PowerGenerator.recommendations(nil, 'WEG', 'metalico')).not_to include(@power_gen1, @power_gen2,
                                                                                      @power_gen3, @power_gen4)
      end

      it 'returns power generators that matches with price and structure_type' do
        expect(PowerGenerator.recommendations(10_000, nil, 'metalico')).to include()
        expect(PowerGenerator.recommendations(10_000, nil, 'metalico')).not_to include(@power_gen1, @power_gen2,
                                                                                       @power_gen3, @power_gen4)
      end

      it 'returns power generators that matches with manufacturer' do
        expect(PowerGenerator.recommendations(nil, 'WEG', nil)).to include()
        expect(PowerGenerator.recommendations(nil, 'WEG', nil)).not_to include(@power_gen1, @power_gen2,
                                                                               @power_gen3, @power_gen4)
      end

      it' returns power generators that matches with structure_type' do
        expect(PowerGenerator.recommendations(nil, nil, 'metalico')).to include()
        expect(PowerGenerator.recommendations(nil, nil, 'metalico')).not_to include(@power_gen1, @power_gen2,
                                                                                    @power_gen3, @power_gen4)
      end

      it 'returns power generators that matches with capital limit' do
        expect(PowerGenerator.recommendations(30_000, nil, nil)).to include()
        expect(PowerGenerator.recommendations(30_000, nil, nil)).not_to include(@power_gen1, @power_gen2,
                                                                                @power_gen3, @power_gen4)
      end
    end

    xcontext 'when a match is not found' do

    end
  end
end
