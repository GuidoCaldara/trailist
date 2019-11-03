Rails.application.routes.draw do
  get "race_photos/create"
  get "race_photos/index"
  get "race_photos/destroy"
  root "pages#home"
  devise_for :organizers, controllers: { registrations: "organizers/registrations" }
  devise_for :users
  resources :organizations
  resources :races do
    resources :race_prices, only: [:index, :create]
    resources :race_photos, only: [:index, :create]
  end
  resources :race_prices, only: [:destroy]
  resources :race_photos, only: [:destroy]
end
