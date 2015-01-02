Rails.application.routes.draw do
  root "stations#index"
  devise_for :users

  resources :stations, only: [:index, :show]

  namespace :admin do
    resources :stations
  end
end
