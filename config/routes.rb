Rails.application.routes.draw do
  root to: 'races#index'
  get '/auth/:provider/callback' => 'users#new'
  get '/signup' => 'users#new', as: :signup
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resources :races, only: [:index, :show]

  get '/settings/profile' => 'users#edit', as: :settings

  # NOTE For Let's Encrypt
  get '/.well-known' => redirect('/.well-known')

  resources :users, param: :username, path: '/', only: [:show, :update, :destroy]
  resources :users, only: [:new, :create]

  namespace :api do
    resources :races, only: [:index, :show, :create, :destroy]
    resources :candidates, only: [] do
      resource :vote, only: [:create]
    end
  end

  match '*path' => 'application#render_404', via: :all
end
