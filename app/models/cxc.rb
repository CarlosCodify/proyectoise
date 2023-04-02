# frozen_string_literal: true

class Cxc < ApplicationRecord
  self.table_name = 'cxc'

  belongs_to :cliente, foreign_key: 'id_cliente', class_name: 'Cliente'
  belongs_to :concepto_cxc, foreign_key: 'id_concepto_cxc', class_name: 'ConceptoCxc'
end
