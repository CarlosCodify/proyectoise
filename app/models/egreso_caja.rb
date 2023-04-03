# frozen_string_literal: true

class EgresoCaja < ActiveRecord::Base
  self.table_name = 'egreso_caja'

  belongs_to :movimiento_caja, foreign_key: 'id_movimiento_caja', class_name: 'MovimientoCaja'
end
