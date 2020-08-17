Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users do
    collection do
      get :current
    end
  end

  root to: 'application#home'
end
