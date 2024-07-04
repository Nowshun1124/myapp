Rails.application.routes.draw do
  root 'static_pages#home'
  get "/message", to: 'static_pages#message'
  
end
