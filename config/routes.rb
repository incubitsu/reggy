# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources :sessions, only: %i[new create] do
    get :logout, on: :collection
  end
  resources :registrations, only: %i[new create]
  get 'user' => 'user#edit'
  patch 'user' => 'user#update'

  resources :forgot_passwords
end
