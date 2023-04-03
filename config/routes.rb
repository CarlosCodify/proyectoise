# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :proveedor, only: %i[index]
      resources :cxp, only: %i[index]
      resources :cxc, only: %i[index]
      resources :concepto_movimiento_bancos
      resources :usuarios
      resources :contactos do
        get :clientes, on: :collection
      end
      resources :sucursales do
        resources :activo_fijos, only: %i[index create]
        resources :cajas, only: %i[create]
      end
      resources :bancos do
        resources :cuenta_bancos, only: %i[index create]
      end
      resources :cuenta_bancos, only: %i[show update destroy] do
        resources :movimiento_bancos, only: %i[index create_deposit create_withdrawal] do
          post :create_deposit, on: :collection
          post :create_withdrawal, on: :collection
        end
        get :index_all, on: :collection
      end
      resources :tipo_activo_fijos
      resources :activo_fijos, only: %i[show update destroy] do
        get :index_all, on: :collection
      end
      resources :movimiento_bancos, only: %i[show update destroy] do
        get :index_all, on: :collection
      end
      get 'clientes/:cliente_id', to: 'contactos#show_cliente'
      get 'proveedor/:proveedor_id/find_cxp', to: 'cxp#find_cxp'
      get 'clientes/:cliente_id/find_cxc', to: 'cxc#find_cxc'
      get 'clientes/:cliente_id/creditos', to: 'creditos#index'
      get 'clientes/:cliente_id/cuotas', to: 'cuotas#index'
      post 'cajas/:caja_id/cierre', to: 'cajas#cierre'
      post 'cxc/:cxc_id/ingreso_cxc', to: 'cajas#ingreso_cxc'
      post 'cuota/:cuota_id/ingreso_cuota', to: 'cajas#ingreso_cuota'
      post 'movimiento_caja/ingreso', to: 'cajas#ingreso'
      post 'movimiento_caja/egreso', to: 'cajas#egreso'
      post 'cxp/:cxp_id/egreso_cxp', to: 'cajas#egreso_cxp'
      get 'movimientos_caja', to: 'cajas#movimientos_caja'
      get 'cajas/:caja_id/find_movimientos_caja', to: 'cajas#find_movimientos_caja'
      get 'cajas/:caja_id', to: 'cajas#show'
    end
  end
end
