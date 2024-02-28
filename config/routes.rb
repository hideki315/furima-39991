Rails.application.routes.draw do
  get 'itemss/index'
  get 'itemss/new'
  devise_for :users
  root to: 'top#index'

  resources :users, only: [:new, :create]
  resources :items, only: [:index, :new, :create]
end
