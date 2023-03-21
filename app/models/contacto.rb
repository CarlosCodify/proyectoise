class Contacto < ApplicationRecord
	self.table_name = "contacto"
    has_many :cuenta_bancos, foreign_key: 'id_contacto', class_name: 'CuentaBanco'
  
    validates :nombre, presence: true
    validates :apellido_paterno, presence: true
    validates :telefono, presence: true
  end