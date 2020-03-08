class PowerGenerator < ApplicationRecord
  include PgSearch::Model
  validates :name, :description, :image_url, :manufacturer,
            :price, :kwp, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 3000 }

  enum structure_type: { metalico: 0, ceramico: 1, fibrocimento: 2,
                         laje: 3, solo: 4, trapezoidal: 5 }

  pg_search_scope :simple_search, against: %i[name description
                                              manufacturer price]

  # TODO, Refatorar Codigo. Acredito que dessa forma esta sobrecarregando o
  # banco de dados

  scope :recommendations, lambda { |price, manufacturer, structure_type|
    relation = all
    relation = relation.where('price <= ?', price) if price.present?
    if manufacturer.present?
      relation = relation.where(manufacturer: manufacturer)
    end
    if structure_type.present?
      relation = relation.where(structure_type: structure_type)
    end
    relation
  }

  def cubic_weight
    height * lenght * width * 300
  end

  def minor_weight
    [weight, cubic_weight].min
  end
end
