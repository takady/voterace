Rails.application.routes.draw do
  root to: 'top#index'
  get '/auth/:provider/callback' => 'users#new'
  get '/signup' => 'users#new', as: :signup
  get '/logout' => 'sessions#destroy', as: :logout

  post '/races/vote' => 'races#vote'
  resources :races, only: [:index, :show, :new, :create, :destroy]

  get '/settings/profile' => 'users#edit', as: :settings

  resources :users, param: :username, path: '/', only: [:show, :update, :destroy]
  resources :users, only: [:new, :create]
end
