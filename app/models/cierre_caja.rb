# frozen_string_literal: true

class CierreCaja < ApplicationRecord
  self.table_name = 'cierre_caja'

  belongs_to :caja, foreign_key: 'id_caja', class_name: 'Caja'
  belongs_to :usuario, foreign_key: 'id_usuario', class_name: 'Usuario'

  validates :fecha, presence: true
  validates :monto_efectivo, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :monto_sistema, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :observaciones, length: { maximum: 255 }
end
