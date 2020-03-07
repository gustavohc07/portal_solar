class AddressFinder
  attr_reader :cep

  def initialize(cep)
    @cep = cep
  end

  def get_address
    response = Faraday.get "https://viacep.com.br/ws/#{@cep}/json/"
    json = JSON.parse(response.body, symbolize_names: true)
    return 'CEP incorreto' if json[:erro] == true

    json
  end
end