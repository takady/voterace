Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :update, :destroy]
  resources :races, only: [:index, :show, :new, :create, :destroy]

  namespace :api, constraints: { format: :json } do
    resources :votes, only: [:create, :update], defaults: {format: :json}
    resources :users, only: [:show, :create, :update, :destroy], defaults: {format: :json}
    resources :races, only: [:index, :show, :create, :destroy], defaults: {format: :json}
  end
end
