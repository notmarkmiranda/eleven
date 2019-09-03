Rails.application.routes.draw do
  root "pages#index"
  devise_for :users

  get "/dashboard", to: "dashboard#show"

  resources :leagues
  resources :seasons
  resources :games
end
