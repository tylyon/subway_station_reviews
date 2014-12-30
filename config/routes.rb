Rails.application.routes.draw do
  root "stations#index"
  devise_for :users

  resources :stations, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create, :show]
  end
end
