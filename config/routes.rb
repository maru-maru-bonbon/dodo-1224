Rails.application.routes.draw do
  devise_for :users
  root to: 'plans#index'
  resources :plans, only: [:index]
end
