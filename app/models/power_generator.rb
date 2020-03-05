class PowerGenerator < ApplicationRecord
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
end
