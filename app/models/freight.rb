class Freight < ApplicationRecord
  validates :state, :weight_min, :weight_max, :cost, presence: true

  def self.cost_calculate(weight, cep_state)
    freight = where(state: cep_state)
              .where('? BETWEEN weight_min AND weight_max', weight)[0]
    freight&.cost
  end
end

# Pegar o estado por meio do CEP fornecido
# Com o estado, pegar o range do estado da tabela 'freight'
# Com o peso do gerador, encontrar o range do custo do frete
#
# Models envolvidos: Freight e PowerGenerator
