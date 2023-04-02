# frozen_string_literal: true

class ChangeIdToBigintInConceptoMovimientoBanco < ActiveRecord::Migration[7.0]
  def change
    change_column :concepto_movimiento_banco, :id, :bigint, auto_increment: true
  end
end
