Rails.application.routes.draw do

  namespace :admin do 
    resources :items
    resources :categories
    resources :items
    resources :orders
  end

  resources :items
  resources :orders

  get      "/home", to: "home#get"
  get     "/login", to: "sessions#new"
  post    "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  root "home#get" 
end
