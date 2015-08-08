Rails.application.routes.draw do
  resources :votes, only: [:create, :update], defaults: {format: :json}
  resources :users, only: [:show, :create, :update, :destroy], defaults: {format: :json}
  resources :questions, only: [:index, :show, :create, :destroy], defaults: {format: :json}
end
