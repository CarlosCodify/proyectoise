class Api::V1::ActivoFijosController < ApplicationController
  before_action :set_activo_fijo, only: %i[ show update destroy ]
  before_action :set_sucursal, only: %i[ index create ]

  # GET /api/v1/sucursales/:sucursal_id/activo_fijos
  def index
    @activo_fijos = @sucursal.activo_fijos.includes(:tipo_activo_fijo, :sucursal)

    render json: @activo_fijos.as_json(include: [{ sucursal: { only: %i[id nombre direccion] } },
                                                 { tipo_activo_fijo: { only: %i[id nombre] } }])
  end

  def index_all
    @activo_fijos = ActivoFijo.all.includes(:tipo_activo_fijo, :sucursal)

    render json: @activo_fijos.as_json(include: [{ sucursal: { only: %i[id nombre direccion] } },
                                                 { tipo_activo_fijo: { only: %i[id nombre] } }])
  end

  # GET /api/v1/activo_fijos/1
  def show
    render json: @activo_fijo
  end

  # POST /api/v1/sucursales/:sucursal_id/activo_fijos
  def create
    @activo_fijo = @sucursal.activo_fijos.build(activo_fijo_params)

    if @activo_fijo.save
      render json: @activo_fijo, status: :created
    else
      render json: @activo_fijo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/activo_fijos/1
  def update
    if @activo_fijo.update(activo_fijo_params)
      render json: @activo_fijo
    else
      render json: @activo_fijo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/activo_fijos/1
  def destroy
    @activo_fijo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activo_fijo
      @activo_fijo = ActivoFijo.find(params[:id])
    end

    def set_sucursal
      @sucursal = Sucursal.find(params[:sucursale_id])
    end

    # Only allow a list of trusted parameters through.
    def activo_fijo_params
      params.require(:activo_fijo).permit(:nombre, :fecha_adquisicion, :costo_adquisicion, :porcentaje_vida_util,
                                          :fecha_baja, :codigo, :id_tipo_activo_fijo)
    end
end
