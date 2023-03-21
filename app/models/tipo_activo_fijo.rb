class TipoActivoFijo < ApplicationRecord
	self.table_name = "tipo_activo_fijo"
	has_many :activo_fijos, foreign_key: "id_tipo_activo_fijo", class_name: "ActivoFijo"
end
