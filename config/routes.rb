Rails.application.routes.draw do
  get 'users/complete_profile'
  root "pages#home"
  devise_for :users#, controllers: { registrations: "users/registrations" }
  resources :users, only: [:show] do
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
