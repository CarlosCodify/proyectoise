Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sucursales do
        resources :activo_fijos, shallow: true
      end
      resources :bancos do
        resources :cuenta_bancos, only: %i[index create]
      end
      resources :cuenta_bancos, only: %i[show update destroy]
      resources :tipo_activo_fijos
    end
  end
end
