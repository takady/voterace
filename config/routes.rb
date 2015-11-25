Rails.application.routes.draw do
  root to: 'top#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  post '/races/vote' => 'races#vote'
  resources :races, only: [:index, :show, :new, :create, :destroy]

  get '/mypage' => 'users#mypage'
  resources :users, only: [:show, :edit, :update, :destroy]
end
