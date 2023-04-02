# frozen_string_literal: true

class Deposito < ActiveRecord::Base
  self.table_name = 'deposito'

  belongs_to :movimiento_banco, foreign_key: 'id_movimiento_banco', class_name: 'MovimientoBanco'
end
