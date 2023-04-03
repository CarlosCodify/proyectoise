# frozen_string_literal: true

class IngresoCuotas < ActiveRecord::Base
  self.table_name = 'ingreso_cuotas'

  belongs_to :cxc, foreign_key: 'id_cxc', class_name: 'Cxc'
  belongs_to :ingreso_caja, foreign_key: 'id_ingreso_caja', class_name: 'IngresoCaja'
end
