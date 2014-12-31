Rails.application.routes.draw do
  root "stations#index"
  devise_for :users

  resources :stations, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]
  namespace :admin do
    resources :stations
  end

end
