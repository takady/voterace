Rails.application.routes.draw do
  root to: 'top#index'
  get '/auth/twitter/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  post '/races/vote' => 'races#vote'
  resources :races, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy]

  namespace :api, constraints: { format: :json } do
    resources :races, only: [:index, :show, :create, :destroy]
    resources :votes, only: [:create, :update]
    resources :users, only: [:show, :create, :update, :destroy]
  end
end
