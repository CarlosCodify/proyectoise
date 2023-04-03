class Cuota < ApplicationRecord
  self.table_name = 'cuota'

	belongs_to :credito, foreign_key: 'id_credito', class_name: 'Credito'
  has_one :cliente, through: :credito
	has_one :contacto, through: :credito
end
