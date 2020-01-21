Rails.application.routes.draw do
  devise_for :users

  resources :products do
  	resources :comments , only: [:create, :update, :destroy]
  end
  resources :order_items

  resource :carts, only: [:show]
  resources :charges, only: [:new, :create]
  get '/charges/validate_coupon', to: 'charges#validate_coupon', as: :validate_coupon
  resources :coupons
  root to: "products#index"


  
  get 'index' => 'pages#index', as: 'home'
  get 'about' => 'pages#about', as: 'about'
  get 'contact' => 'pages#contact', as: 'contact'


end
