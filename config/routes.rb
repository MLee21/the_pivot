Rails.application.routes.draw do

  namespace :admin do 
    resources :items
    resources :categories
    resources :items
    resources :orders
  end

  resources :items
  resources :orders

  get      "/cart", to: "cart#get"
  get      "/home", to: "home#get"
  get     "/login", to: "sessions#new"
  post    "/login", to: "sessions#create"
  post  "/options", to: "admin#get"
  delete "/logout", to: "sessions#destroy"

  root "home#new" 
end
