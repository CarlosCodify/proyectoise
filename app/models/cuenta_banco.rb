class CuentaBanco < ApplicationRecord
	self.table_name = "cuenta_banco"

	belongs_to :contacto, foreign_key: 'id_contacto', class_name: 'Contacto'
  belongs_to :banco, foreign_key: 'id_banco', class_name: 'Banco'

  validates :numero_cuenta, presence: true, uniqueness: true
  validates :tipo_moneda, presence: true
  validates :saldo, presence: true
  validates :fecha_apertura, presence: true
  validates :estado, presence: true, inclusion: { in: ['A', 'I'] }
end
