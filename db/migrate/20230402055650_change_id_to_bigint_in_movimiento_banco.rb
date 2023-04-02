# frozen_string_literal: true

class ChangeIdToBigintInMovimientoBanco < ActiveRecord::Migration[7.0]
  def change
    change_column :movimiento_banco, :id, :bigint, auto_increment: true
  end
end
