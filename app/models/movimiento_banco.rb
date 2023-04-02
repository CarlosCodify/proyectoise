# frozen_string_literal: true

class MovimientoBanco < ApplicationRecord
  self.table_name = 'movimiento_banco'

  belongs_to :cuenta_banco, foreign_key: 'id_cuenta_banco', class_name: 'CuentaBanco'
  belongs_to :concepto_movimiento_banco, foreign_key: 'id_concepto_movimiento_banco',
                                         class_name: 'ConceptoMovimientoBanco'
  belongs_to :usuario, foreign_key: 'id_usuario', class_name: 'Usuario'
  has_many :deposito, foreign_key: 'id_movimiento_banco', class_name: 'Deposito'
  has_many :retiro, foreign_key: 'id_movimiento_banco', class_name: 'Retiro'

  validates :monto, presence: true, numericality: { greater_than: 0 }
  validates :fecha, presence: true
  validates :descripcion, presence: true
end
