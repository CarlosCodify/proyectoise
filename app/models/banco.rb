# frozen_string_literal: true

class Banco < ApplicationRecord
  self.table_name = 'banco'
  has_many :cuenta_bancos, foreign_key: 'id_banco', class_name: 'CuentaBanco'
  validates :nombre, presence: true
end
