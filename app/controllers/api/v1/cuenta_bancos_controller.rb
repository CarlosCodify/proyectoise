# frozen_string_literal: true

module Api
  module V1
    class CuentaBancosController < ApplicationController
      before_action :set_cuenta_banco, only: %i[show update destroy]
      before_action :set_banco, only: %i[index create]

      # GET /api/v1/cuenta_bancos
      def index
        @cuenta_bancos = @banco.cuenta_bancos.includes(:banco, :contacto)

        render json: @cuenta_bancos.as_json(include: [{ banco: { only: %i[id nombre] } },
                                                      { contacto: { only: %i[id nombre apellido_paterno
                                                                             apellido_materno] } }])
      end

      def index_all
        @cuenta_bancos = CuentaBanco.all.includes(:banco, :contacto)

        render json: @cuenta_bancos.as_json(include: [{ banco: { only: %i[id nombre] } },
                                                      { contacto: { only: %i[id nombre apellido_paterno
                                                                             apellido_materno] } }])
      end

      # GET /api/v1/cuenta_bancos/1
      def show
        render json: @cuenta_banco
      end

      # POST /api/v1/cuenta_bancos
      def create
        @cuenta_banco = @banco.cuenta_bancos.build(cuenta_banco_params)

        if @cuenta_banco.save
          render json: @cuenta_banco, status: :created
        else
          render json: @cuenta_banco.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/cuenta_bancos/1
      def update
        if @cuenta_banco.update(cuenta_banco_params)
          render json: @cuenta_banco
        else
          render json: @cuenta_banco.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/cuenta_bancos/1
      def destroy
        @cuenta_banco.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_cuenta_banco
        @cuenta_banco = CuentaBanco.find(params[:id])
      end

      def set_banco
        @banco = Banco.find(params[:banco_id])
      end

      # Only allow a list of trusted parameters through.
      def cuenta_banco_params
        params.require(:cuenta_banco).permit(:numero_cuenta, :tipo_moneda, :saldo, :fecha_apertura, :estado,
                                             :fecha_cierre, :id_contacto)
      end
    end
  end
end
