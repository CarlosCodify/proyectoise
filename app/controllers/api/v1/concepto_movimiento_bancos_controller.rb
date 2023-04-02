# frozen_string_literal: true

module Api
  module V1
    class ConceptoMovimientoBancosController < ApplicationController
      before_action :set_concepto_movimiento_banco, only: %i[show update destroy]

      # GET /api/v1/concepto_movimiento_bancos
      def index
        @concepto_movimiento_bancos = ConceptoMovimientoBanco.all

        render json: @concepto_movimiento_bancos
      end

      # GET /api/v1/concepto_movimiento_bancos/1
      def show
        render json: @concepto_movimiento_banco
      end

      # POST /api/v1/concepto_movimiento_bancos
      def create
        @concepto_movimiento_banco = ConceptoMovimientoBanco.new(concepto_movimiento_banco_params)

        if @concepto_movimiento_banco.save
          render json: @concepto_movimiento_banco, status: :created
        else
          render json: @concepto_movimiento_banco.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/concepto_movimiento_bancos/1
      def update
        if @concepto_movimiento_banco.update(concepto_movimiento_banco_params)
          render json: @concepto_movimiento_banco
        else
          render json: @concepto_movimiento_banco.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/concepto_movimiento_bancos/1
      def destroy
        @concepto_movimiento_banco.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_concepto_movimiento_banco
        @concepto_movimiento_banco = ConceptoMovimientoBanco.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def concepto_movimiento_banco_params
        params.require(:concepto_movimiento_banco).permit(:nombre)
      end
    end
  end
end
