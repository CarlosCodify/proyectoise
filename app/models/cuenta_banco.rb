# frozen_string_literal: true

class CuentaBanco < ApplicationRecord
  self.table_name = 'cuenta_banco'

  belongs_to :contacto, foreign_key: 'id_contacto', class_name: 'Contacto'
  belongs_to :banco, foreign_key: 'id_banco', class_name: 'Banco'
  has_many :movimiento_bancos, foreign_key: 'id_cuenta_banco', class_name: 'MovimientoBanco'

  validates :numero_cuenta, presence: true, uniqueness: true
  validates :tipo_moneda, presence: true
  validates :saldo, presence: true
  validates :fecha_apertura, presence: true
  validates :estado, presence: true, inclusion: { in: %w[A I] }
end
