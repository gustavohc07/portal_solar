require 'rails_helper'
# TODO, validations.
RSpec.describe Freight, type: :model do
  it 'is valid with state, cost and max & min weight' do
    freight = create(:freight, state: 'MG',
                               weight_max: 80,
                               weight_min: 71,
                               cost: 60.52)

    expect(freight).to be_valid
  end
  describe 'cost calculation' do
    it 'returns a cost with state and power gen weight' do
      power_gen = create(:power_generator, weight: 95)

      create(:freight, state: 'MG',
                       weight_max: 110,
                       weight_min: 101,
                       cost: 88.62)
      create(:freight, state: 'SP',
                       weight_max: 100,
                       weight_min: 91,
                       cost: 88.62)
      create(:freight, state: 'MG',
                       weight_max: 100,
                       weight_min: 91,
                       cost: 60.52)

      freight = Freight.cost_calculate(power_gen.weight, 'MG')
      expect(freight).to eq 60.52
    end

    it 'return empty with no matches' do
      create(:freight, state: 'MG',
                       weight_max: 110,
                       weight_min: 101,
                       cost: 88.62)

      freight = Freight.cost_calculate(111, 'MG')
      expect(freight).to be_nil
    end

    it 'is nil without weight param' do
      create(:freight, state: 'MG',
                       weight_max: 110,
                       weight_min: 101,
                       cost: 88.62)

      freight = Freight.cost_calculate(nil, 'MG')
      expect(freight).to be_nil
    end

    it 'is nil without cep state param' do
      create(:freight, state: 'MG',
                       weight_max: 110,
                       weight_min: 101,
                       cost: 88.62)

      freight = Freight.cost_calculate(105, nil)
      expect(freight).to be_nil
    end
  end
end
