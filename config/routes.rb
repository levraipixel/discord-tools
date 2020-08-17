Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :channels

  resources :characters

  resources :cities

  resources :guilds do
    resources :channels, only: :index
    member do
      get :import
    end
  end

  resources :teams

  resources :users do
    collection do
      get :current
    end
  end

  get 'convert' => 'application#convert'

  root to: 'application#home'
end
