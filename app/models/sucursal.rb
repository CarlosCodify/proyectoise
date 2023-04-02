# frozen_string_literal: true

class Sucursal < ApplicationRecord
  self.table_name = 'sucursal'
  has_many :activo_fijos, foreign_key: 'id_sucursal', class_name: 'ActivoFijo'
end
