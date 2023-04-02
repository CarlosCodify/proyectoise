# frozen_string_literal: true

module Api
  module V1
    class BancosController < ApplicationController
      before_action :set_banco, only: %i[show update destroy]

      # GET /api/v1/bancos
      def index
        @bancos = Banco.all

        render json: @bancos
      end

      # GET /api/v1/bancos/1
      def show
        render json: @banco
      end

      # POST /api/v1/bancos
      def create
        @banco = Banco.new(banco_params)

        if @banco.save
          render json: @banco, status: :created
        else
          render json: @banco.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/bancos/1
      def update
        if @banco.update(banco_params)
          render json: @banco
        else
          render json: @banco.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/bancos/1
      def destroy
        @banco.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_banco
        @banco = Banco.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def banco_params
        params.require(:banco).permit(:nombre)
      end
    end
  end
end
