Rails.application.routes.draw do
  devise_for :users

  resources :products do
  	resources :comments , only: [:create, :update, :destroy]
  end

  
  root to: "pages#index"
  get 'index' => 'pages#index', as: 'home'
  get 'about' => 'pages#about', as: 'about'
  get 'contact' => 'pages#contact', as: 'contact'



end
