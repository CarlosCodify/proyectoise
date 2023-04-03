class Api::V1::CreditosController < ApplicationController
  before_action :set_credito, only: %i[ show update destroy ]

  # GET /api/v1/creditos
  def index
    @cliente = Cliente.find(params[:cliente_id])
    @creditos = @cliente.creditos.includes(:contacto)

    render json: @creditos.as_json(include: [ {cliente: { only: %i[id credito_limite]}},
                                              { contacto: { only: %i[nombre apellido_paterno
                                                                     apellido_materno] } }])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_credito
    @credito = Credito.find(params[:id])
  end
end
