require 'rails_helper'

RSpec.describe AddressFinder do
  context 'status 200' do
    it 'find user address with CEP' do
      address = AddressFinder.new('38408200').address

      expect(address[:uf]).to eq 'MG'
      expect(address[:localidade]).to eq 'Uberlândia'
      expect(address[:bairro]).to eq 'Santa Mônica'
    end

    it 'return error message if CEP not found' do
      address = AddressFinder.new('38408201').address

      expect(address[:message]).to eq 'CEP invalido.'
    end
  end
  context 'status 400' do
    it 'returns error message if invalid CEP format given' do
      address = AddressFinder.new('384.@(09').address

      expect(address[:message]).to eq 'CEP invalido.'
    end

    it 'returns error message if empty CEP given' do
      address = AddressFinder.new('').address

      expect(address[:message]).to eq 'CEP invalido.'
    end

    it 'returns error message if CEP nil' do
      address = AddressFinder.new(nil).address

      expect(address[:message]).to eq 'CEP invalido.'
    end
    it 'returns error message if CEP small than 8 characters' do
      address = AddressFinder.new('384').address

      expect(address[:message]).to eq 'CEP invalido.'
    end

    it 'returns error message if CEP greater than 8 characters' do
      address = AddressFinder.new('38408201000').address

      expect(address[:message]).to eq 'CEP invalido.'
    end
  end
end
