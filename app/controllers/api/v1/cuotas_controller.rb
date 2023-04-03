# frozen_string_literal: true

module Api
  module V1
    class CuotasController < ApplicationController
      def index
        @cliente = Cliente.find(params[:cliente_id])
        @cuotas = @cliente.cuotas.includes(:contacto)

        render json: @cuotas.as_json(include: [{ cliente: { only: %i[id credito_limite] } },
                                               { contacto: { only: %i[nombre apellido_paterno
                                                                      apellido_materno] } }])
      end
    end
  end
end
