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
  resources :cart
  resources :charges

  # get            "/payment", to: "orders#payment"
  # get      "/pay_at_pickup", to: "orders#pay_at_pickup"
  get               "/home", to: "home#get"
  get              "/login", to: "sessions#new"
  post             "/login", to: "sessions#create"
  delete          "/logout", to: "sessions#destroy"
  post      "admin/options", to: "admin/options#route"

  root "home#new" 
end
