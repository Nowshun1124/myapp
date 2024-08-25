Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get "/message", to: 'static_pages#message'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :artists
  resources :lives, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
