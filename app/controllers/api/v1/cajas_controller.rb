# frozen_string_literal: true

module Api
  module V1
    class CajasController < ApplicationController
      before_action :set_caja, only: %i[cierre find_movimientos_caja show]
      before_action :set_sucursal, only: %i[create]

      def create
        @caja = @sucursal.cajas.build(caja_params)
        @caja.fecha_apertura = DateTime.now
        @caja.estado = 'A'
        @caja.saldo_actual = @caja.saldo_inicial
        if @caja.save
          render json: @caja, status: :created
        else
          render json: @caja.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @caja
      end

      def cierre
        return render json: { message: 'La caja ya ha sido cerrada.' } if @caja.estado == 'I'

        usuario = Usuario.find(cierre_caja_params[:id_usuario])
        return render json: { message: 'Solo un administrador de caja puede realizar un cierre de caja.' } unless usuario.id_tipo_usuario == 4

        @cierre_caja = @caja.cierre_cajas.build(cierre_caja_params)
        @cierre_caja.fecha = DateTime.now
        @cierre_caja.monto_sistema = @caja.saldo_actual

        if @cierre_caja.save
          @caja.update(estado: 'I')
          if (@cierre_caja.monto_efectivo = @caja.saldo_actual)
            render json: { message: 'La caja se ha cerrado correctamente.' }, status: :created
          elsif @cierre_caja.monto_efectivo > @caja.saldo_actual
            render json: { message: 'La caja se ha cerrado con observaciones. Tomar en cuenta que el monto en efectivo es mayor al del sistema.' },
                   status: :created
          else
            render json: { message: 'La caja se ha cerrado con observaciones. Tomar en cuenta que el monto en efectivo es menor al del sistema.' },
                   status: :created
          end
        else
          render json: @cierre_caja.errors, status: :unprocessable_entity
        end
      end

      def ingreso_cxc
        ActiveRecord::Base.transaction do
          cxc = Cxc.find(params[:cxc_id])
          movimiento_caja = MovimientoCaja.new(movimiento_caja_params)
          movimiento_caja.fecha = DateTime.now
          movimiento_caja.id_contacto = cxc.id_cliente

          if movimiento_caja.save
            cxc.update(monto_pagado: movimiento_caja.monto, monto_deuda_actual: cxc.monto_deuda_actual - movimiento_caja.monto)
            cxc.update(estado: 'C') if cxc.monto_deuda_actual.zero?
            ingreso_caja = IngresoCaja.create(id_movimiento_caja: movimiento_caja.id)
            IngresoCuentasCobrar.create(cxc: cxc, ingreso_caja: ingreso_caja)
            caja = movimiento_caja.caja
            caja.saldo_actual = caja.saldo_actual + movimiento_caja.monto
            caja.save

            render json: movimiento_caja, status: :created
          else
            render json: movimiento_caja.errors, status: :unprocessable_entity
          end
        end
      end

      def ingreso_cuota
        ActiveRecord::Base.transaction do
          cuota = Cuota.find(params[:cuota_id])
          movimiento_caja = MovimientoCaja.new(movimiento_caja_params)
          movimiento_caja.fecha = DateTime.now
          movimiento_caja.monto = cuota.total
          movimiento_caja.id_contacto = cuota.contacto.id

          if movimiento_caja.save
            cuota.update(estado: 'C')
            ingreso_caja = IngresoCaja.create(id_movimiento_caja: movimiento_caja.id)
            IngresoCuotas.create(id_cuota: cuota.id, ingreso_caja: ingreso_caja)
            caja = movimiento_caja.caja
            caja.saldo_actual = caja.saldo_actual + movimiento_caja.monto
            caja.save

            render json: movimiento_caja, status: :created
          else
            render json: movimiento_caja.errors, status: :unprocessable_entity
          end
        end
      end

      def ingreso
        ActiveRecord::Base.transaction do
          movimiento_caja = MovimientoCaja.new(movimiento_caja_params)
          movimiento_caja.fecha = DateTime.now

          if movimiento_caja.save
            IngresoCaja.create(id_movimiento_caja: movimiento_caja.id)
            caja = movimiento_caja.caja
            caja.saldo_actual = caja.saldo_actual + movimiento_caja.monto
            caja.save
            render json: movimiento_caja, status: :created
          else
            render json: movimiento_caja.errors, status: :unprocessable_entity
          end
        end
      end

      def egreso
        ActiveRecord::Base.transaction do
          movimiento_caja = MovimientoCaja.new(movimiento_caja_params)
          movimiento_caja.fecha = DateTime.now
          caja = movimiento_caja.caja
          if caja.saldo_actual < movimiento_caja.monto
            return render json: { message: 'No se puede realizar un egreso de un monto mayor al saldo de la caja.' }
          end

          if movimiento_caja.save
            EgresoCaja.create(id_movimiento_caja: movimiento_caja.id)
            caja.saldo_actual = caja.saldo_actual - movimiento_caja.monto
            caja.save

            render json: movimiento_caja, status: :created
          else
            render json: movimiento_caja.errors, status: :unprocessable_entity
          end
        end
      end

      def egreso_cxp
        ActiveRecord::Base.transaction do
          cxp = Cxp.find(params[:cxp_id])
          movimiento_caja = MovimientoCaja.new(movimiento_caja_params)
          movimiento_caja.fecha = DateTime.now
          caja = movimiento_caja.caja

          if caja.saldo_actual < movimiento_caja.monto
            return render json: { message: 'No se puede realizar un egreso de un monto mayor al saldo de la caja.' }
          end

          if movimiento_caja.save
            cxp.update(monto_pagado: movimiento_caja.monto, deuda_actual: cxp.deuda_actual - movimiento_caja.monto)
            cxp.update(estado: 'C') if cxp.deuda_actual.zero?
            egreso_caja = EgresoCaja.create(id_movimiento_caja: movimiento_caja.id)
            EgresoCuentasPagar.create(id_cxp: cxp.id, egreso_caja: egreso_caja)
            caja.saldo_actual = caja.saldo_actual - movimiento_caja.monto
            caja.save
            render json: movimiento_caja, status: :created
          else
            render json: movimiento_caja.errors, status: :unprocessable_entity
          end
        end
      end

      def movimientos_caja
        @movimiento_cajas = MovimientoCaja
                            .select("movimiento_caja.*, CASE WHEN ingreso_caja.id IS NOT NULL THEN 'Ingreso' ELSE 'Egreso' END AS tipo")
                            .left_joins(:ingreso_caja, :egreso_caja).includes(:concepto_movimiento_caja, :caja)

        render json: @movimiento_cajas.as_json(include: [{ concepto_movimiento_caja: { only: %i[nombre] } },
                                                         {
                                                           caja: { only: %i[id nombre estado] }
                                                         }])
      end

      def find_movimientos_caja
        @movimiento_cajas = @caja.movimiento_cajas
                                                  .select("movimiento_caja.*, CASE WHEN ingreso_caja.id IS NOT NULL THEN 'Ingreso' ELSE 'Egreso' END AS tipo")
                                                  .left_outer_joins(:ingreso_caja, :egreso_caja)
                                                  .includes(:concepto_movimiento_caja, :caja)

        result = @movimiento_cajas.as_json(include: [{ concepto_movimiento_caja: { only: %i[nombre] } },
                                                     {
                                                       caja: { only: %i[id nombre estado] }
                                                     }])
        total_ingresos = 0
        total_egresos = 0

        @movimiento_cajas.each do |movimiento_caja|
          if IngresoCaja.find_by(id_movimiento_caja: movimiento_caja.id).present?
            total_ingresos += movimiento_caja.monto
          else
            total_egresos += movimiento_caja.monto
          end
        end

        render json: {
          result: result,
          estado_actual_caja: {
            saldo_inicial: @caja.saldo_inicial,
            saldo_actual: @caja.saldo_actual,
            total_ingresos: total_ingresos,
            total_egresos: total_egresos,
            estado: @caja.estado == 'A' ? 'Activa' : 'Cerrada',
          }
        }
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_caja
        @caja = Caja.find(params[:caja_id])
      end

      def set_sucursal
        @sucursal = Sucursal.find(params[:sucursale_id])
      end

      # Only allow a list of trusted parameters through.
      def caja_params
        params.require(:caja).permit(:nombre, :saldo_inicial, :observaciones, :id_usuario)
      end

      def cierre_caja_params
        params.require(:cierre_caja).permit(:monto_efectivo, :monto_sistema, :observaciones, :id_usuario)
      end

      def movimiento_caja_params
        params.require(:movimiento_caja).permit(:descripcion, :id_concepto_movimiento_caja, :monto, :id_caja, :id_contacto)
      end
    end
  end
end
