class AddCubicWeightToPowerGenerator < ActiveRecord::Migration[5.2]
  def change
    add_column :power_generators, :cubic_weight, :float
    PowerGenerator.all.each do |power_generator|
      power_generator.update_attributes!(cubic_weight: power_generator.cubic_weight)
    end
  end
end
