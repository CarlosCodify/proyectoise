# frozen_string_literal: true

module Api
  module V1
    class MovimientoBancosController < ApplicationController
      before_action :set_movimiento_banco, only: %i[show update destroy]
      before_action :set_cuenta_banco, only: %i[index create_deposit create_withdrawal]

      # GET /api/v1/movimiento_bancos
      def index
        @movimiento_bancos = @cuenta_banco.movimiento_bancos
                                          .select("movimiento_banco.*, CASE WHEN retiro.id IS NOT NULL THEN 'Retiro' ELSE 'Depósito' END AS tipo")
                                          .left_joins(:retiro, :deposito).includes(:concepto_movimiento_banco, cuenta_banco: :banco)
                                          

        render json: @movimiento_bancos.as_json(include: [{ concepto_movimiento_banco: { only: %i[nombre] } },
                                                          {
                                                            cuenta_banco: { include: { banco: { only: %i[id nombre] } } }
                                                          }
                                                         ])
      end

      def index_all
        @movimiento_bancos = MovimientoBanco
                             .select("movimiento_banco.*, CASE WHEN retiro.id IS NOT NULL THEN 'Retiro' ELSE 'Depósito' END AS tipo")
                             .left_joins(:retiro, :deposito).includes(:concepto_movimiento_banco, cuenta_banco: :banco)

        render json: @movimiento_bancos.as_json(include: [{ concepto_movimiento_banco: { only: %i[nombre] } },
                                                          {
                                                            cuenta_banco: { include: { banco: { only: %i[id nombre] } } }
                                                          }
                                                         ])
      end
      # GET /api/v1/movimiento_bancos/1
      def show
        render json: @movimiento_banco
      end

      # POST /api/v1/movimiento_bancos
      def create_deposit
        @movimiento_banco = @cuenta_banco.movimiento_bancos.build(movimiento_banco_params)
        @movimiento_banco.fecha ||= DateTime.now

        if @movimiento_banco.save
          saldo = @movimiento_banco.cuenta_banco.saldo
          @movimiento_banco.cuenta_banco.update(saldo: saldo + @movimiento_banco.monto)
          deposito = @movimiento_banco.deposito.build
          deposito.save

          render json: @movimiento_banco, status: :created
        else
          render json: @movimiento_banco.errors, status: :unprocessable_entity
        end
      end

      # POST /api/v1/movimiento_bancos
      def create_withdrawal
        @movimiento_banco = @cuenta_banco.movimiento_bancos.build(movimiento_banco_params)
        @movimiento_banco.fecha ||= DateTime.now

        if @cuenta_banco.saldo >= @movimiento_banco.monto
          if @movimiento_banco.save
            saldo = @movimiento_banco.cuenta_banco.saldo
            @movimiento_banco.cuenta_banco.update(saldo: saldo - @movimiento_banco.monto)
            retiro = @movimiento_banco.retiro.build
            retiro.save

            render json: @movimiento_banco, status: :created
          else
            render json: @movimiento_banco.errors, status: :unprocessable_entity
          end
        else
          render json: { message: "No se puede retirar un monto mayor al saldo actual de la cuenta. El saldo actual de la cuenta es de #{@cuenta_banco.saldo}."}, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/movimiento_bancos/1
      def destroy
        @movimiento_banco.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_movimiento_banco
        @movimiento_banco = MovimientoBanco.find(params[:id])
      end

      def set_cuenta_banco
        @cuenta_banco = CuentaBanco.find(params[:cuenta_banco_id])
      end

      # Only allow a list of trusted parameters through.
      def movimiento_banco_params
        params.require(:movimiento_banco).permit(:monto, :fecha, :id_concepto_movimiento_banco, :descripcion, :id_usuario)
      end
    end
  end
end
