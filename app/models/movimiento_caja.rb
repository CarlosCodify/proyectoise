# frozen_string_literal: true

class MovimientoCaja < ApplicationRecord
  self.table_name = 'movimiento_caja'

  belongs_to :caja, foreign_key: 'id_caja', class_name: 'Caja'
  belongs_to :concepto_movimiento_caja, foreign_key: 'id_concepto_movimiento_caja', class_name: 'ConceptoMovimientoCaja'
  belongs_to :contacto, foreign_key: 'id_contacto', class_name: 'Contacto'

  validates :monto, presence: true, numericality: { greater_than: 0 }
  validates :fecha, presence: true
  validates :descripcion, presence: true, length: { maximum: 255 }
end
