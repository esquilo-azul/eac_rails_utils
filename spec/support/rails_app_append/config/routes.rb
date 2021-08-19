# frozen_string_literal: true

Rails.application.routes.draw do
  resources :jobs do
    collection do
      get 'search'
    end
  end
  resources :users
end
