class Credito < ApplicationRecord
  self.table_name = 'credito'

	belongs_to :cxc, foreign_key: 'id_cxc', class_name: 'Cxc'
	has_many :cuotas, foreign_key: 'id_credito', class_name: 'Cuota'
	has_one :cliente, through: :cxc
	has_one :contacto, through: :cxc
end