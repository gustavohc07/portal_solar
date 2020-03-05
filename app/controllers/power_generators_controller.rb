class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def recommendations
    @manufacturer = params[:manufacturer]
    @price = params[:price]
    @structure_type = params[:structure_type]

    @power_generators = PowerGenerator.recommendations(@price, @manufacturer, @structure_type)
    render :index
  end
end
