Rails.application.routes.draw do
  devise_for :users

  resources :products do
  	resources :comments , only: [:create, :update, :destroy]
  end
  
  resources :order_items
  resources :charges, only: [:new, :create]
  resource :cart, only: [:show]

  get '/charges/validate_coupon', to: 'charges#validate_coupon', as: :validate_coupon
  get 'index' => 'pages#index', as: 'home'
  get 'about' => 'pages#about', as: 'about'
  get 'contact' => 'pages#contact', as: 'contact'
    
  root to: "products#index"
end
