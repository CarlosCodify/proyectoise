# frozen_string_literal: true

class Caja < ApplicationRecord
  self.table_name = 'caja'

  has_many :cierre_cajas, foreign_key: 'id_caja', class_name: 'CierreCaja'
  belongs_to :sucursal, foreign_key: 'id_sucursal', class_name: 'Sucursal'
  belongs_to :usuario, foreign_key: 'id_usuario', class_name: 'Usuario'

  validates :nombre, presence: true, length: { maximum: 255 }
  validates :saldo_inicial, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :saldo_actual, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :estado, presence: true, inclusion: { in: %w[A I], message: "El estado debe ser 'A' o 'I'" }
  validates :observaciones, length: { maximum: 255 }
  validates :fecha_apertura, presence: true
end
