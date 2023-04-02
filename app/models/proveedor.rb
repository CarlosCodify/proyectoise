# frozen_string_literal: true

class Proveedor < ApplicationRecord
  self.table_name = 'proveedor'

  has_many :cxps, foreign_key: 'id_proveedor', class_name: 'Cxp'
end
