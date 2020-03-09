class AddressFinder
  attr_reader :cep

  def initialize(cep)
    @cep = cep
  end

  def address
    response = Faraday.get "https://viacep.com.br/ws/#{@cep}/json/"
    return status_400(response) if response.status == 400

    status_200(response)
  end

  def status_200(response)
    return unless response.status == 200

    json = JSON.parse(response.body, symbolize_names: true)
    return { message: 'CEP inválido.' } if json[:erro] == true

    json
  end

  def status_400(response)
    { message: 'CEP inválido.' } if response.status == 400
  end
end
