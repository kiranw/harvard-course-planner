Rails.application.routes.draw do
  get 'main/index'
  get 'courses/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :course, only: [:index]
  root to: 'courses#index'
end
