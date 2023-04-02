# frozen_string_literal: true

class Retiro < ActiveRecord::Base
  self.table_name = 'retiro'

  belongs_to :movimiento_banco, foreign_key: 'id_movimiento_banco', class_name: 'MovimientoBanco'
end
