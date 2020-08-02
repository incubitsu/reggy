# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources :registrations, only: %i[new create]
  get 'user' => 'user#edit'
  patch 'user' => 'user#update'
end
