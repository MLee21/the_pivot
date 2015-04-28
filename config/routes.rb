Rails.application.routes.draw do

  namespace :admin do 
    resources :items
    resources :categories
    resources :items
    resources :orders
  end

  resources :items
  resources :orders
  resources :users

  get           "/cart", to: "cart#get"
  get           "/home", to: "home#get"
  get          "/login", to: "sessions#new"
  post         "/login", to: "sessions#create"
  delete      "/logout", to: "sessions#destroy"
  post  "admin/options", to: "admin/options#route"

  root "home#new" 
end
