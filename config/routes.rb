Rails.application.routes.draw do
  root to: 'top#index'
  get '/auth/twitter/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  post '/races/vote' => 'races#vote'
  resources :races, only: [:index, :show, :new, :create, :destroy]

  get '/mypage' => 'users#mypage'
  resources :users, only: [:edit, :update, :destroy]
end
