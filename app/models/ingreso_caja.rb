# frozen_string_literal: true

class IngresoCaja < ActiveRecord::Base
  self.table_name = 'ingreso_caja'

  belongs_to :movimiento_caja, foreign_key: 'id_movimiento_caja', class_name: 'MovimientoCaja'
  has_many :ingreso_cuentas_cobrar, foreign_key: 'id_ingreso_caja', class_name: 'IngresoCuentasCobrar'

  has_many :cxc, through: :ingreso_cuentas_cobrar
end
