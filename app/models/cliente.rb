# frozen_string_literal: true

class Cliente < ApplicationRecord
  self.table_name = 'cliente'

  belongs_to :contacto, foreign_key: 'id', class_name: 'Contacto'
  has_many :cxcs, foreign_key: 'id_cliente', class_name: 'Cxc'
  has_many :cxps, foreign_key: 'id_cliente', class_name: 'Cxc'
end
