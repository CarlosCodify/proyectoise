Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tipo_activo_fijos
      resources :sucursales do
        resources :activo_fijos, shallow: true
      end
    end
  end
end
