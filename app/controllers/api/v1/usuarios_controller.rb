class Api::V1::UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[ show update destroy ]

  # GET /api/v1/usuarios
  def index
    @usuarios = Usuario.all

    render json: @usuarios.as_json(include: [{ contacto: { only: %i[id nombre apellido_materno apellido_paterno] } }])
  end

  # GET /api/v1/usuarios/1
  def show
    render json: @usuario.as_json(include: [{ contacto: { only: %i[id nombre apellido_materno apellido_paterno] } }])
  end

  # POST /api/v1/usuarios
  def create
    @contacto=  Contacto.new(contacto_params)
    if @contacto.save
      @usuario = @contacto.usuarios.build(usuario_params)
  
      if @usuario.save
        render json: @usuario.as_json(include: [{ contacto: { only: %i[id nombre apellido_materno apellido_paterno] } }]), status: :created
      else
        render json: @usuario.errors, status: :unprocessable_entity
      end
    else
      render json: @contacto.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/usuarios/1
  def update
    if @usuario.update(usuario_params)
      render json: @usuario
    else
      render json: @usuario.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/usuarios/1
  def destroy
    @usuario.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contacto_params
      params.require(:contacto).permit(:nombre, :apellido_paterno, :apellido_materno, :telefono, :direccion, :ci, :nit, :email, :genero)
    end

    def usuario_params
      params.require(:usuario).permit(:estado, :login, :password, :id_tipo_usuario)
    end
end
