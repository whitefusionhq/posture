# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :toggleable do
    collection do
      post :toggle
    end
  end

  resources :bookmarks, concerns: :toggleable
  resources :favorites, concerns: :toggleable
  resources :post_actions

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  match "/logout", to: "sessions#destroy", via: [:delete, :post]

  put "/", to: "home#index"
  get "/navbars", to: "home#navbars", as: :navbars
  root to: "home#index"
end
