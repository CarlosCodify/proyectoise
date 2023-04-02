# frozen_string_literal: true

class ActivoFijo < ApplicationRecord
  self.table_name = 'activo_fijo'

  belongs_to :sucursal, foreign_key: 'id_sucursal', class_name: 'Sucursal'
  belongs_to :tipo_activo_fijo, foreign_key: 'id_tipo_activo_fijo', class_name: 'TipoActivoFijo'

  validates :nombre, presence: true
  validates :fecha_adquisicion, presence: true
  validates :costo_adquisicion, presence: true, numericality: true
  validates :porcentaje_vida_util, presence: true, numericality: true
  validates :id_sucursal, presence: true
  validates :id_tipo_activo_fijo, presence: true
end
