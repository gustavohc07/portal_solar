require 'rails_helper'

RSpec.describe AddressFinder do
  it 'find user address with CEP' do
    address = AddressFinder.new('38408200').get_address

    expect(address[:uf]).to eq 'MG'
    expect(address[:localidade]).to eq 'Uberlândia'
    expect(address[:bairro]).to eq 'Santa Mônica'
  end

  it 'return error message if CEP not found' do
    address = AddressFinder.new('38408201').get_address

    expect(address).to eq 'CEP incorreto'
  end
end