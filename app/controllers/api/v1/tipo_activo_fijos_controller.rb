class Api::V1::TipoActivoFijosController < ApplicationController
  before_action :set_tipo_activo_fijo, only: %i[ show update destroy ]

  # GET /api/v1/tipo_activo_fijos
  def index
    @tipo_activo_fijos = TipoActivoFijo.all

    render json: @tipo_activo_fijos
  end

  # GET /api/v1/tipo_activo_fijos/1
  def show
    render json: @tipo_activo_fijo
  end

  # POST /api/v1/tipo_activo_fijos
  def create
    @tipo_activo_fijo = TipoActivoFijo.new(tipo_activo_fijo_params)

    if @tipo_activo_fijo.save
      render json: @tipo_activo_fijo, status: :created
    else
      render json: @tipo_activo_fijo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tipo_activo_fijos/1
  def update
    if @tipo_activo_fijo.update(tipo_activo_fijo_params)
      render json: @tipo_activo_fijo
    else
      render json: @tipo_activo_fijo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tipo_activo_fijos/1
  def destroy
    @tipo_activo_fijo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_activo_fijo
      @tipo_activo_fijo = TipoActivoFijo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_activo_fijo_params
      params.require(:tipo_activo_fijo).permit(:nombre)
    end
end
