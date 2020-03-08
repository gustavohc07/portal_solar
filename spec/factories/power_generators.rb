FactoryBot.define do
  factory :power_generator do
    name { 'Trifasico' }
    description { '2 MPPTs para adaptacao versatil e diferentes tipos...' }
    image_url { 'https://go.aws/2Tq8svj' }
    manufacturer { 'WEG' }
    structure_type { 0 }
    price { 49_990.0 }
    height { 2 }
    width { 0.5 }
    lenght { 1.5 }
    weight { 200 }
    kwp { 17 }
    cubic_weight { 450 }
  end
end
