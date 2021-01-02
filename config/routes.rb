# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookmarks
  resources :post_actions

  post "/test-submit", to: "home#test_submit"

  put "/", to: "home#index"
  root to: "home#index"
end
