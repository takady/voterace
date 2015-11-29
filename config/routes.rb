Rails.application.routes.draw do
  root to: 'top#index'
  get '/auth/:provider/callback' => 'users#new'
  get '/signup' => 'users#new', as: :signup
  get '/logout' => 'sessions#destroy', as: :logout

  post '/races/vote' => 'races#vote'
  resources :races, only: [:index, :show, :new, :create, :destroy]

  get '/mypage' => 'users#mypage'

  resources :users, param: :username, path: '/', only: [:show, :edit, :update, :destroy]
  resources :users, only: [:new, :create]
end
