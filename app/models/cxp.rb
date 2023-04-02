# frozen_string_literal: true

class Cxp < ApplicationRecord
  self.table_name = 'cxp'

  belongs_to :concepto_cxp, foreign_key: 'id_concepto_cxp', class_name: 'ConceptoCxp'
  belongs_to :proveedor
end
