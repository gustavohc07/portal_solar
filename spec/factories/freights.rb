FactoryBot.define do
  factory :freight do
    state { 'MG' }
    weight_max { 90 }
    weight_min { 81 }
    cost { 57.036 }
  end
end
