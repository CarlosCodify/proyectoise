# frozen_string_literal: true

class Usuario < ApplicationRecord
  self.table_name = 'usuario'

  belongs_to :contacto, foreign_key: 'id', class_name: 'Contacto'
  belongs_to :tipo_usuario, foreign_key: 'id_tipo_usuario', class_name: 'TipoUsuario'

  validates :estado, presence: true, length: { is: 1 }
  validates :login, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { maximum: 255 }
end
