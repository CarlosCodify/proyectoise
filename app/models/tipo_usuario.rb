class TipoUsuario < ApplicationRecord
  self.table_name = "tipo_usuario"
  has_many :usuarios, foreign_key: "id_tipo_usuario", class_name: "Usuario"
end
