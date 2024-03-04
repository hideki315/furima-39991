Rails.application.routes.draw do
  get 'itemss/index'
  get 'itemss/new'
  devise_for :users
  root to: 'items#index'

  resources :items, only: [:index, :new, :create, :show,]
end
