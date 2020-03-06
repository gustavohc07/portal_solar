Rails.application.routes.draw do
  root to: 'power_generators#index'
  resources :power_generators, only: %i[index show]

  get 'recommendations', controller: :power_generators
end
