# frozen_string_literal: true

module Api
  module V1
    class SucursalesController < ApplicationController
      before_action :set_sucursal, only: %i[show update destroy]

      # GET /api/v1/sucursales
      def index
        @sucursales = Sucursal.all

        render json: @sucursales
      end

      # GET /api/v1/sucursales/1
      def show
        render json: @sucursal
      end

      # POST /api/v1/sucursales
      def create
        @sucursal = Sucursal.new(sucursal_params)

        if @sucursal.save
          render json: @sucursal, status: :created
        else
          render json: @sucursal.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/sucursales/1
      def update
        if @sucursal.update(sucursal_params)
          render json: @sucursal
        else
          render json: @sucursal.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/sucursales/1
      def destroy
        @sucursal.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_sucursal
        @sucursal = Sucursal.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def sucursal_params
        params.require(:sucursal).permit(:nombre, :direccion)
      end
    end
  end
end
