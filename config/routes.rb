Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :products
  resources :cats
  resources :users
  post "users/:id/edit" => "users#update"
  resources :carts
  post "carts/show" => "carts#update"
  get "orders/complete" => "orders#show"
  resources :orders

  get "logout", to: "sessions#destroy"

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end

  get 'homes/new'

end
