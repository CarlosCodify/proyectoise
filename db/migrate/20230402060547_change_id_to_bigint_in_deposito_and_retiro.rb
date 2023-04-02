# frozen_string_literal: true

class ChangeIdToBigintInDepositoAndRetiro < ActiveRecord::Migration[7.0]
  def change
    change_column :deposito, :id, :bigint, auto_increment: true
    change_column :retiro, :id, :bigint, auto_increment: true
  end
end
