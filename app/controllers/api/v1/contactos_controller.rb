# frozen_string_literal: true

module Api
  module V1
    class ContactosController < ApplicationController
      before_action :set_contacto, only: %i[show update destroy]

      # GET /api/v1/contactos
      def index
        @contactos = Contacto.all

        render json: @contactos
      end

      # GET /api/v1/contactos/1
      def show
        render json: @contacto
      end

      # POST /api/v1/contactos
      def create
        @contacto = Contacto.new(contacto_params)

        if @contacto.save
          render json: @contacto, status: :created
        else
          render json: @contacto.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/contactos/1
      def update
        if @contacto.update(contacto_params)
          render json: @contacto
        else
          render json: @contacto.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/contactos/1
      def destroy
        @contacto.destroy
      end

      def clientes
        @clientes = Cliente.all.includes(:contacto)

        render json: @clientes.as_json(include: [{ contacto: { only: %i[id nombre apellido_paterno
                                                                        apellido_materno] } }])
      end

      def show_cliente
        @cliente = Cliente.find(params[:cliente_id])

        render json: @cliente.as_json(include: [{ contacto: { only: %i[id nombre apellido_paterno
                                                                       apellido_materno] } }])
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_contacto
        @contacto = Contacto.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def contacto_params
        params.require(:contacto).permit(:nombre, :apellido_paterno, :apellido_materno, :telefono, :direccion, :ci, :nit,
                                         :email, :genero)
      end
    end
  end
end
