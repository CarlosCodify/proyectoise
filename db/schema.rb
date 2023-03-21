# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_21_194246) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_graphql"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "pgjwt"
  enable_extension "pgsodium"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "aal_level", ["aal1", "aal2", "aal3"]
  create_enum "factor_status", ["unverified", "verified"]
  create_enum "factor_type", ["totp", "webauthn"]
  create_enum "key_status", ["default", "valid", "invalid", "expired"]
  create_enum "key_type", ["aead-ietf", "aead-det", "hmacsha512", "hmacsha256", "auth", "shorthash", "generichash", "kdf", "secretbox", "secretstream", "stream_xchacha20"]

  create_table "activo_fijo", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255
    t.date "fecha_adquisicion"
    t.decimal "costo_adquisicion", precision: 12, scale: 2
    t.decimal "porcentaje_vida_util", precision: 5, scale: 2
    t.date "fecha_baja"
    t.string "codigo", limit: 20
    t.integer "id_sucursal", null: false
    t.integer "id_tipo_activo_fijo", null: false
    t.index ["codigo"], name: "activo_fijo_codigo_key", unique: true
  end

  create_table "ajuste", id: :serial, force: :cascade do |t|
    t.datetime "fecha", precision: nil, null: false
    t.string "observaciones", limit: 255
    t.integer "id_almacen", null: false
    t.integer "id_concepto_ajuste", null: false
    t.integer "id_personal", null: false
  end

  create_table "ajuste_detalle", id: :serial, force: :cascade do |t|
    t.integer "cantidad", default: 0, null: false
    t.string "tipo_ajuste", limit: 1, null: false
    t.integer "id_catalogo", null: false
    t.integer "id_ajuste", null: false
    t.check_constraint "tipo_ajuste = 'S'::bpchar OR tipo_ajuste = 'R'::bpchar", name: "ajuste_detalle_tipo_ajuste_check"
  end

  create_table "almacen", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "ubicacion", limit: 255
    t.string "descripcion", limit: 255
    t.string "activo", limit: 1, default: "A"
    t.integer "id_sucursal", null: false
  end

  create_table "banco", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255
  end

  create_table "caja", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255
    t.decimal "saldo_inicial", precision: 12, scale: 2
    t.decimal "saldo_actual", precision: 12, scale: 2
    t.string "estado", limit: 1
    t.string "observaciones", limit: 255
    t.datetime "fecha_apertura", precision: nil
    t.integer "id_sucursal"
    t.integer "id_usuario"
    t.check_constraint "estado = ANY (ARRAY['A'::bpchar, 'I'::bpchar])", name: "caja_estado_check"
  end

  create_table "catalogo", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "codigo_interno", limit: 20, null: false
    t.string "codigo_de_barras", limit: 20
    t.string "codigo_proveedor", limit: 20
    t.string "descripcion", limit: 255
    t.string "activo", limit: 1, default: "A"
    t.integer "id_unidad_medida", null: false
    t.integer "id_tipo_catalogo", null: false
    t.integer "id_subcategoria", null: false
    t.index ["codigo_de_barras"], name: "catalogo_codigo_de_barras_key", unique: true
    t.index ["codigo_interno"], name: "catalogo_codigo_interno_key", unique: true
    t.index ["codigo_proveedor"], name: "catalogo_codigo_proveedor_key", unique: true
  end

  create_table "categoria", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255, null: false
  end

  create_table "categoria_cliente", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre", limit: 50
    t.decimal "porcentaje_desc", precision: 5, scale: 2
  end

  create_table "cierre_caja", id: :serial, force: :cascade do |t|
    t.datetime "fecha", precision: nil
    t.integer "id_caja"
    t.decimal "monto_efectivo", precision: 12, scale: 2
    t.decimal "monto_sistema", precision: 12, scale: 2
    t.integer "id_usuario"
    t.string "observaciones", limit: 255
  end

  create_table "cliente", id: :integer, default: nil, force: :cascade do |t|
    t.integer "id_categoria_cliente", null: false
    t.decimal "credito_limite", precision: 12, scale: 2
  end

  create_table "compra", id: :serial, force: :cascade do |t|
    t.integer "id_personal", null: false
    t.integer "id_almacen", null: false
    t.string "estado", limit: 50
    t.date "fecha"
    t.string "tipo_pago", limit: 1
    t.integer "id_proveedor", null: false
  end

  create_table "concepto_ajuste", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "descripcion", limit: 255
  end

  create_table "concepto_cxc", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100
  end

  create_table "concepto_cxp", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100
  end

  create_table "concepto_ingreso", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "descripcion", limit: 255
  end

  create_table "concepto_movimiento_banco", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255
  end

  create_table "concepto_movimiento_caja", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255
  end

  create_table "concepto_salida", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "descripcion", limit: 255
  end

  create_table "concepto_traspaso", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "descripcion", limit: 255
  end

  create_table "contacto", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 50, null: false
    t.string "apellido_paterno", limit: 50, null: false
    t.string "apellido_materno", limit: 50
    t.string "telefono", limit: 15
    t.string "direccion", limit: 255
    t.string "ci", limit: 15
    t.string "nit", limit: 15
    t.string "email", limit: 255
    t.string "genero", limit: 1
  end

  create_table "credito", id: :serial, force: :cascade do |t|
    t.decimal "saldo_actual", precision: 12, scale: 2
    t.datetime "fecha_credito", precision: nil
    t.string "estado", limit: 1, null: false
    t.decimal "porcentaje_interes", precision: 5, scale: 2
    t.integer "plazo_a_meses", null: false
    t.integer "id_cxc", null: false
    t.integer "id_personal", null: false
  end

  create_table "cuenta_banco", id: :serial, force: :cascade do |t|
    t.string "numero_cuenta", limit: 20
    t.string "tipo_moneda", limit: 50
    t.decimal "saldo", precision: 12, scale: 2
    t.integer "id_contacto"
    t.date "fecha_apertura"
    t.string "estado", limit: 1
    t.date "fecha_cierre"
    t.integer "id_banco"
    t.check_constraint "estado = ANY (ARRAY['A'::bpchar, 'I'::bpchar])", name: "cuenta_banco_estado_check"
  end

  create_table "cuota", id: :serial, force: :cascade do |t|
    t.integer "id_credito", null: false
    t.date "fecha_pago", null: false
    t.decimal "interes", precision: 12, scale: 2, null: false
    t.decimal "capital", precision: 12, scale: 2, null: false
    t.decimal "total", precision: 12, scale: 2, null: false
    t.string "estado", limit: 1, null: false
    t.integer "numero_cuota"
  end

  create_table "cxc", id: :serial, force: :cascade do |t|
    t.integer "id_cliente", null: false
    t.date "fecha_vencimiento"
    t.datetime "fecha_registro", precision: nil
    t.decimal "deuda_capital", precision: 12, scale: 2
    t.decimal "monto_pagado", precision: 12, scale: 2
    t.decimal "monto_deuda_actual", precision: 12, scale: 2
    t.integer "id_concepto_cxc", null: false
    t.string "es_credito", limit: 1, null: false
    t.string "estado", limit: 1, null: false
    t.integer "id_personal", null: false
    t.check_constraint "es_credito = 'S'::bpchar OR es_credito = 'N'::bpchar", name: "cxc_es_credito_check"
  end

  create_table "cxp", id: :serial, force: :cascade do |t|
    t.string "estado", limit: 1
    t.date "fecha_vencimiento"
    t.datetime "fecha_creacion", precision: nil
    t.integer "id_concepto_cxp", null: false
    t.integer "id_proveedor", null: false
    t.decimal "monto_capital", precision: 12, scale: 2, null: false
    t.decimal "monto_pagado", precision: 12, scale: 2, null: false
    t.decimal "deuda_actual", precision: 12, scale: 2, null: false
    t.integer "id_personal", null: false
  end

  create_table "deposito", id: :serial, force: :cascade do |t|
    t.integer "id_movimiento_banco"
  end

  create_table "detalle_compra", id: :serial, force: :cascade do |t|
    t.integer "id_catalogo", null: false
    t.integer "id_compra", null: false
    t.decimal "precio", precision: 12, scale: 2
    t.integer "cantidad"
  end

  create_table "detalle_lista", id: :serial, force: :cascade do |t|
    t.integer "id_catalogo", null: false
    t.integer "id_lista_precio", null: false
    t.decimal "precio", precision: 12, scale: 2
  end

  create_table "detalle_proforma", id: :serial, force: :cascade do |t|
    t.integer "id_proforma", null: false
    t.integer "id_catalogo", null: false
    t.integer "cantidad", null: false
    t.decimal "precio", precision: 12, scale: 2
  end

  create_table "detalle_venta", id: :serial, force: :cascade do |t|
    t.integer "id_venta", null: false
    t.integer "id_catalogo", null: false
    t.integer "cantidad", null: false
    t.decimal "precio", precision: 12, scale: 2
    t.decimal "costo", precision: 12, scale: 2
  end

  create_table "egreso_caja", id: :serial, force: :cascade do |t|
    t.integer "id_movimiento_caja"
  end

  create_table "egreso_cuentas_pagar", id: :serial, force: :cascade do |t|
    t.integer "id_egreso_caja"
    t.integer "id_cxp"
  end

  create_table "ingreso", id: :serial, force: :cascade do |t|
    t.datetime "fecha", precision: nil, null: false
    t.decimal "costo_transporte", precision: 12, scale: 2, default: "0.0"
    t.decimal "costo_carga", precision: 12, scale: 2, default: "0.0"
    t.decimal "costo_almacenes", precision: 12, scale: 2, default: "0.0"
    t.decimal "otros_costos", precision: 12, scale: 2, default: "0.0"
    t.string "observaciones", limit: 255
    t.integer "id_compra"
    t.integer "id_concepto_ingreso", null: false
    t.integer "id_personal", null: false
    t.integer "id_almacen", null: false
  end

  create_table "ingreso_caja", id: :serial, force: :cascade do |t|
    t.integer "id_movimiento_caja"
  end

  create_table "ingreso_cuentas_cobrar", id: :serial, force: :cascade do |t|
    t.integer "id_ingreso_caja"
    t.integer "id_cxc"
  end

  create_table "ingreso_cuotas", id: :serial, force: :cascade do |t|
    t.integer "id_ingreso_caja"
    t.integer "id_cuota"
  end

  create_table "ingreso_detalle", id: :serial, force: :cascade do |t|
    t.integer "cantidad", default: 0, null: false
    t.decimal "costo_unitario", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "id_ingreso", null: false
    t.integer "id_catalogo", null: false
  end

  create_table "inventario", primary_key: ["id_almacen", "id_catalogo"], force: :cascade do |t|
    t.integer "id_almacen", null: false
    t.integer "id_catalogo", null: false
    t.decimal "costo_actual", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "cantidad_actual", default: 0, null: false
  end

  create_table "lista_precio", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 50
    t.date "fecha_inicial"
    t.date "fecha_expiracion"
    t.string "estado", limit: 1
    t.integer "id_personal", null: false
  end

  create_table "movimiento_banco", id: :serial, force: :cascade do |t|
    t.decimal "monto", precision: 12, scale: 2
    t.date "fecha"
    t.integer "id_cuenta_banco"
    t.integer "id_concepto_movimiento_banco"
    t.string "descripcion", limit: 255
    t.integer "id_usuario"
  end

  create_table "movimiento_caja", id: :serial, force: :cascade do |t|
    t.decimal "monto", precision: 12, scale: 2
    t.datetime "fecha", precision: nil
    t.integer "id_caja"
    t.string "descripcion", limit: 255
    t.integer "id_concepto_movimiento_caja"
    t.integer "id_contacto"
  end

  create_table "personal", id: :integer, default: nil, force: :cascade do |t|
    t.string "estado", limit: 1
    t.date "fecha_contrato"
    t.date "fecha_retiro"
  end

  create_table "proforma", id: :serial, force: :cascade do |t|
    t.integer "id_cliente", null: false
    t.integer "id_personal", null: false
    t.integer "id_almacen", null: false
    t.datetime "fecha", precision: nil
    t.integer "dias_valido", null: false
  end

  create_table "proveedor", id: :integer, default: nil, force: :cascade do |t|
    t.string "razon_social", limit: 50
    t.string "estado", limit: 20
  end

  create_table "retiro", id: :serial, force: :cascade do |t|
    t.integer "id_movimiento_banco"
  end

  create_table "salida", id: :serial, force: :cascade do |t|
    t.datetime "fecha", precision: nil, null: false
    t.string "observaciones", limit: 255
    t.integer "id_personal", null: false
    t.integer "id_concepto_salida", null: false
    t.integer "id_almacen", null: false
  end

  create_table "salida_detalle", id: :serial, force: :cascade do |t|
    t.integer "cantidad", default: 0, null: false
    t.decimal "costo_unitario", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "id_salida", null: false
    t.integer "id_catalogo", null: false
  end

  create_table "subcategoria", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255, null: false
    t.integer "id_categoria", null: false
  end

  create_table "sucursal", id: :serial, force: :cascade do |t|
    t.string "direccion", limit: 255, null: false
    t.string "nombre", limit: 255, null: false
  end

  create_table "tipo_activo_fijo", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 255
  end

  create_table "tipo_catalogo", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
  end

  create_table "tipo_usuario", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre", limit: 50
  end

  create_table "traspaso", id: :serial, force: :cascade do |t|
    t.datetime "fecha", precision: nil, null: false
    t.decimal "costo_transporte", precision: 12, scale: 2, default: "0.0"
    t.decimal "costo_carga", precision: 12, scale: 2, default: "0.0"
    t.decimal "costo_almacenes", precision: 12, scale: 2, default: "0.0"
    t.decimal "otros_costos", precision: 12, scale: 2, default: "0.0"
    t.string "observaciones", limit: 255
    t.integer "id_almacen_origen", null: false
    t.integer "id_almacen_destino", null: false
    t.integer "id_concepto_traspaso", null: false
    t.integer "id_personal", null: false
  end

  create_table "traspaso_detalle", id: :serial, force: :cascade do |t|
    t.integer "cantidad", default: 0, null: false
    t.decimal "costo_unitario", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "id_catalogo", null: false
    t.integer "id_traspaso", null: false
  end

  create_table "unidad_medida", id: :serial, force: :cascade do |t|
    t.string "nombre", limit: 100, null: false
    t.string "abreviatura", limit: 10, null: false
  end

  create_table "usuario", id: :integer, default: nil, force: :cascade do |t|
    t.string "estado", limit: 1, null: false
    t.string "login", limit: 50, null: false
    t.string "password", limit: 255, null: false
    t.integer "id_tipo_usuario", null: false
  end

  create_table "venta", id: :serial, force: :cascade do |t|
    t.integer "id_cliente", null: false
    t.integer "id_personal", null: false
    t.integer "id_almacen", null: false
    t.datetime "fecha", precision: nil
    t.string "tipo_pago", limit: 1, null: false
    t.string "observaciones", limit: 255
  end

  add_foreign_key "activo_fijo", "sucursal", column: "id_sucursal", name: "activo_fijo_id_sucursal_fkey"
  add_foreign_key "activo_fijo", "tipo_activo_fijo", column: "id_tipo_activo_fijo", name: "activo_fijo_id_tipo_activo_fijo_fkey"
  add_foreign_key "ajuste", "almacen", column: "id_almacen", name: "ajuste_id_almacen_fkey"
  add_foreign_key "ajuste", "concepto_ajuste", column: "id_concepto_ajuste", name: "ajuste_id_concepto_ajuste_fkey"
  add_foreign_key "ajuste", "personal", column: "id_personal", name: "ajuste_id_personal_fkey"
  add_foreign_key "ajuste_detalle", "ajuste", column: "id_ajuste", name: "ajuste_detalle_id_ajuste_fkey"
  add_foreign_key "ajuste_detalle", "catalogo", column: "id_catalogo", name: "ajuste_detalle_id_catalogo_fkey"
  add_foreign_key "almacen", "sucursal", column: "id_sucursal", name: "almacen_id_sucursal_fkey"
  add_foreign_key "caja", "sucursal", column: "id_sucursal", name: "caja_id_sucursal_fkey"
  add_foreign_key "caja", "usuario", column: "id_usuario", name: "caja_id_usuario_fkey"
  add_foreign_key "catalogo", "subcategoria", column: "id_subcategoria", name: "catalogo_id_subcategoria_fkey"
  add_foreign_key "catalogo", "tipo_catalogo", column: "id_tipo_catalogo", name: "catalogo_id_tipo_catalogo_fkey"
  add_foreign_key "catalogo", "unidad_medida", column: "id_unidad_medida", name: "catalogo_id_unidad_medida_fkey"
  add_foreign_key "cierre_caja", "caja", column: "id_caja", name: "cierre_caja_id_caja_fkey"
  add_foreign_key "cierre_caja", "usuario", column: "id_usuario", name: "cierre_caja_id_usuario_fkey"
  add_foreign_key "cliente", "categoria_cliente", column: "id_categoria_cliente", name: "cliente_id_categoria_cliente_fkey"
  add_foreign_key "cliente", "contacto", column: "id", name: "cliente_id_fkey"
  add_foreign_key "compra", "almacen", column: "id_almacen", name: "compra_id_almacen_fkey"
  add_foreign_key "compra", "personal", column: "id_personal", name: "compra_id_personal_fkey"
  add_foreign_key "compra", "proveedor", column: "id_proveedor", name: "compra_id_proveedor_fkey"
  add_foreign_key "credito", "cxc", column: "id_cxc", name: "credito_id_cxc_fkey"
  add_foreign_key "credito", "personal", column: "id_personal", name: "credito_id_personal_fkey"
  add_foreign_key "cuenta_banco", "banco", column: "id_banco", name: "cuenta_banco_id_banco_fkey"
  add_foreign_key "cuenta_banco", "contacto", column: "id_contacto", name: "cuenta_banco_titular_contacto_fkey"
  add_foreign_key "cuota", "credito", column: "id_credito", name: "cuota_id_credito_fkey"
  add_foreign_key "cxc", "cliente", column: "id_cliente", name: "cxc_id_cliente_fkey"
  add_foreign_key "cxc", "concepto_cxc", column: "id_concepto_cxc", name: "cxc_id_concepto_cxc_fkey"
  add_foreign_key "cxc", "personal", column: "id_personal", name: "cxc_id_personal_fkey"
  add_foreign_key "cxp", "concepto_cxp", column: "id_concepto_cxp", name: "cxp_id_concepto_cxp_fkey"
  add_foreign_key "cxp", "personal", column: "id_personal", name: "cxp_id_personal_fkey"
  add_foreign_key "cxp", "proveedor", column: "id_proveedor", name: "cxp_id_proveedor_fkey"
  add_foreign_key "deposito", "movimiento_banco", column: "id_movimiento_banco", name: "deposito_id_movimiento_banco_fkey"
  add_foreign_key "detalle_compra", "catalogo", column: "id_catalogo", name: "detalle_compra_id_catalogo_fkey"
  add_foreign_key "detalle_compra", "compra", column: "id_compra", name: "detalle_compra_id_compra_fkey"
  add_foreign_key "detalle_lista", "catalogo", column: "id_catalogo", name: "detalle_lista_id_catalogo_fkey"
  add_foreign_key "detalle_lista", "lista_precio", column: "id_lista_precio", name: "detalle_lista_id_lista_precio_fkey"
  add_foreign_key "detalle_proforma", "catalogo", column: "id_catalogo", name: "detalle_proforma_id_catalogo_fkey"
  add_foreign_key "detalle_proforma", "proforma", column: "id_proforma", name: "detalle_proforma_id_proforma_fkey"
  add_foreign_key "detalle_venta", "catalogo", column: "id_catalogo", name: "detalle_venta_id_catalogo_fkey"
  add_foreign_key "detalle_venta", "venta", column: "id_venta", name: "detalle_venta_id_venta_fkey"
  add_foreign_key "egreso_caja", "movimiento_caja", column: "id_movimiento_caja", name: "egreso_caja_id_movimiento_caja_fkey"
  add_foreign_key "egreso_cuentas_pagar", "cxp", column: "id_cxp", name: "egreso_cuentas_pagar_id_cxp_fkey"
  add_foreign_key "egreso_cuentas_pagar", "ingreso_caja", column: "id_egreso_caja", name: "egreso_cuentas_pagar_id_egreso_caja_fkey"
  add_foreign_key "ingreso", "almacen", column: "id_almacen", name: "ingreso_id_almacen_fkey"
  add_foreign_key "ingreso", "compra", column: "id_compra", name: "ingreso_id_compra_fkey"
  add_foreign_key "ingreso", "concepto_ingreso", column: "id_concepto_ingreso", name: "ingreso_id_concepto_ingreso_fkey"
  add_foreign_key "ingreso", "personal", column: "id_personal", name: "ingreso_id_personal_fkey"
  add_foreign_key "ingreso_caja", "movimiento_caja", column: "id_movimiento_caja", name: "ingreso_caja_id_movimiento_caja_fkey"
  add_foreign_key "ingreso_cuentas_cobrar", "cxc", column: "id_cxc", name: "ingreso_cuentas_cobrar_id_cxc_fkey"
  add_foreign_key "ingreso_cuentas_cobrar", "ingreso_caja", column: "id_ingreso_caja", name: "ingreso_cuentas_cobrar_id_ingreso_caja_fkey"
  add_foreign_key "ingreso_cuotas", "cuota", column: "id_cuota", name: "ingreso_cuotas_id_cuota_fkey"
  add_foreign_key "ingreso_cuotas", "ingreso_caja", column: "id_ingreso_caja", name: "ingreso_cuotas_id_ingreso_caja_fkey"
  add_foreign_key "ingreso_detalle", "catalogo", column: "id_catalogo", name: "ingreso_detalle_id_catalogo_fkey"
  add_foreign_key "ingreso_detalle", "ingreso", column: "id_ingreso", name: "ingreso_detalle_id_ingreso_fkey"
  add_foreign_key "inventario", "almacen", column: "id_almacen", name: "inventario_id_almacen_fkey"
  add_foreign_key "inventario", "catalogo", column: "id_catalogo", name: "inventario_id_catalogo_fkey"
  add_foreign_key "lista_precio", "personal", column: "id_personal", name: "lista_precio_id_personal_fkey"
  add_foreign_key "movimiento_banco", "concepto_movimiento_banco", column: "id_concepto_movimiento_banco", name: "movimiento_banco_id_concepto_movimiento_banco_fkey"
  add_foreign_key "movimiento_banco", "cuenta_banco", column: "id_cuenta_banco", name: "movimiento_banco_id_cuenta_banco_fkey"
  add_foreign_key "movimiento_banco", "usuario", column: "id_usuario", name: "movimiento_banco_id_usuario_fkey"
  add_foreign_key "movimiento_caja", "caja", column: "id_caja", name: "movimiento_caja_id_caja_fkey"
  add_foreign_key "movimiento_caja", "concepto_movimiento_caja", column: "id_concepto_movimiento_caja", name: "movimiento_caja_id_concepto_movimiento_caja_fkey"
  add_foreign_key "movimiento_caja", "contacto", column: "id_contacto", name: "movimiento_caja_id_contacto_fkey"
  add_foreign_key "personal", "contacto", column: "id", name: "personal_id_fkey"
  add_foreign_key "proforma", "cliente", column: "id_cliente", name: "proforma_id_cliente_fkey"
  add_foreign_key "proforma", "personal", column: "id_personal", name: "proforma_id_personal_fkey"
  add_foreign_key "proveedor", "contacto", column: "id", name: "proveedor_id_fkey"
  add_foreign_key "retiro", "movimiento_banco", column: "id_movimiento_banco", name: "retiro_id_movimiento_banco_fkey"
  add_foreign_key "salida", "almacen", column: "id_almacen", name: "salida_id_almacen_fkey"
  add_foreign_key "salida", "concepto_salida", column: "id_concepto_salida", name: "salida_id_concepto_salida_fkey"
  add_foreign_key "salida", "personal", column: "id_personal", name: "salida_id_personal_fkey"
  add_foreign_key "salida_detalle", "catalogo", column: "id_catalogo", name: "salida_detalle_id_catalogo_fkey"
  add_foreign_key "salida_detalle", "salida", column: "id_salida", name: "salida_detalle_id_salida_fkey"
  add_foreign_key "subcategoria", "categoria", column: "id_categoria", name: "subcategoria_id_categoria_fkey"
  add_foreign_key "traspaso", "almacen", column: "id_almacen_destino", name: "traspaso_id_almacen_destino_fkey"
  add_foreign_key "traspaso", "almacen", column: "id_almacen_origen", name: "traspaso_id_almacen_origen_fkey"
  add_foreign_key "traspaso", "concepto_traspaso", column: "id_concepto_traspaso", name: "traspaso_id_concepto_traspaso_fkey"
  add_foreign_key "traspaso", "personal", column: "id_personal", name: "traspaso_id_personal_fkey"
  add_foreign_key "traspaso_detalle", "catalogo", column: "id_catalogo", name: "traspaso_detalle_id_catalogo_fkey"
  add_foreign_key "traspaso_detalle", "traspaso", column: "id_traspaso", name: "traspaso_detalle_id_traspaso_fkey"
  add_foreign_key "usuario", "contacto", column: "id", name: "usuario_id_fkey"
  add_foreign_key "usuario", "tipo_usuario", column: "id_tipo_usuario", name: "usuario_id_tipo_usuario_fkey"
  add_foreign_key "venta", "almacen", column: "id_almacen", name: "venta_id_almacen_fkey"
  add_foreign_key "venta", "cliente", column: "id_cliente", name: "venta_id_cliente_fkey"
  add_foreign_key "venta", "personal", column: "id_personal", name: "venta_id_personal_fkey"
end
