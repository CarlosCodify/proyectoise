# frozen_string_literal: true

class EgresoCuentasPagar < ActiveRecord::Base
  self.table_name = 'egreso_cuentas_pagar'

  belongs_to :cxp, foreign_key: 'id_cxp', class_name: 'Cxp'
  belongs_to :egreso_caja, foreign_key: 'id_egreso_caja', class_name: 'EgresoCaja'
end
