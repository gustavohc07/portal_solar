require 'rails_helper'

describe 'System find user address with cep' do
  it 'successfully' do
    response = Faraday.get 'https://viacep.com.br/ws/38408200/json/'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(json[:cep]).to eq('38408-200')
    expect(json[:logradouro]).to eq('Rua Professor Euler Lannes Bernardes')
    expect(json[:bairro]).to eq('Santa Mônica')
    expect(json[:localidade]).to eq('Uberlândia')
    expect(json[:uf]).to eq('MG')
  end
end