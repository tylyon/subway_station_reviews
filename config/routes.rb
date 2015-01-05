Rails.application.routes.draw do
  root "stations#index"
  devise_for :users

  resources :stations, only: [:index, :show, :new, :create] do
    resources :reviews, except: [:show, :index, :destroy]
  end

  resources :reviews, only: [:destroy]

  namespace :admin do
    resources :stations
    resources :users, only: [:index, :destroy]
  end
end
