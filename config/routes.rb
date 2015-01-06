Rails.application.routes.draw do
  root "stations#index"
  devise_for :users

  resources :stations, only: [:index, :show, :new, :create] do
    resources :reviews, except: [:index, :destroy] do
    end
  end

  resources :reviews, only: [] do
    resources :votes, only: [:destroy]
    get '/up-vote', to: 'votes#up_vote', as: :up_vote
    get '/down-vote', to: 'votes#down_vote', as: :down_vote
  end


  resources :reviews, only: [:destroy]

  namespace :admin do
    resources :stations
  end
end
