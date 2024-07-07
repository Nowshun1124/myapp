Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get "/message", to: 'static_pages#message'
  resources :users
end
