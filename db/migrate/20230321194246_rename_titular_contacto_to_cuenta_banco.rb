# frozen_string_literal: true

class RenameTitularContactoToCuentaBanco < ActiveRecord::Migration[7.0]
  def change
    rename_column :cuenta_banco, :titular_contacto, :id_contacto
  end
end
