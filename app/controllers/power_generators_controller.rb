class PowerGeneratorsController < ApplicationController
  before_action :recommendation_params, only: [:recommendations]

  def index
    @power_generators = PowerGenerator.all
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
  end

  def recommendations
    @power_generators = PowerGenerator.recommendations(@price, @manufacturer,
                                                       @structure_type)
    if @power_generators.empty?
      flash[:notice] = 'Infelizmente nao ha correspondentes.'
      return render :index
    end
    flash[:notice] = 'Veja sua lista de recomendacoes'
    render :index
  end

  def freight_cost
    @power_generator = PowerGenerator.find(params[:id])
    @address = AddressFinder.new(params[:cep]).address
    unless @address[:erro] == true
      @cost = Freight.cost_calculate(@power_generator.weight, @address[:uf])
    end
    render :show
  end

  private

  def recommendation_params
    manufacturer = params[:manufacturer]
    price = params[:price]
    structure_type = params[:structure_type]

    @manufacturer = manufacturer unless manufacturer.empty?
    @price = price unless price.empty?
    @structure_type = structure_type unless structure_type.empty?
  end
end
