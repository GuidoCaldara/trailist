Rails.application.routes.draw do
  root "pages#home"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:show, :edit, :update] do
    collection do
      get :complete_profile
      patch :save_profile
    end
  end

  resources :organizations do
    collection do
      get :add_your_group
      get :organizer_dashboard
    end
  end

  resources :races do
    member do
      patch :update_description
    end
    resources :race_prices, only: [:index, :create]
    resources :race_photos, only: [:index, :create]
    resources :reviews, only: [:create]
  end
  resources :race_prices, only: [:destroy]
  resources :race_photos, only: [:destroy]
end
