# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :usuarios
      resources :contactos
      resources :sucursales do
        resources :activo_fijos, only: %i[index create]
      end
      resources :bancos do
        resources :cuenta_bancos, only: %i[index create]
      end
      resources :cuenta_bancos, only: %i[show update destroy] do
        get :index_all, on: :collection
      end
      resources :tipo_activo_fijos
      resources :activo_fijos, only: %i[show update destroy] do
        get :index_all, on: :collection
      end
    end
  end
end
