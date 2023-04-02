# frozen_string_literal: true

module Api
  module V1
    class ProveedorController < ApplicationController
      def index
        @proveedores = Proveedor.all

        render json: @proveedores
      end
    end
  end
end
