# frozen_string_literal: true

class Contacto < ApplicationRecord
  self.table_name = 'contacto'
  has_many :cuenta_bancos, foreign_key: 'id_contacto', class_name: 'CuentaBanco'
  has_many :usuarios, foreign_key: 'id', class_name: 'Usuario'

  validates :nombre, presence: true
  validates :apellido_paterno, presence: true
  validates :telefono, presence: true
end
