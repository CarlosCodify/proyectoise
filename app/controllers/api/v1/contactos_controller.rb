class Api::V1::ContactosController < ApplicationController
  before_action :set_contacto, only: %i[ show update destroy ]

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
      render json: @contacto, status: :created, location: @contacto
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contacto_params
      params.require(:contacto).permit( :nombre, :apellido_paterno, :apellido_materno, :telefono, :direccion, :ci, :nit, :email, :genero)
    end
end

