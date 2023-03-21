CREATE TABLE contacto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    ci VARCHAR(15),
    nit VARCHAR(15),
    email VARCHAR(255),
    genero CHAR(1)

);

CREATE TABLE proveedor(                                                                                                                                                                        
id INT PRIMARY KEY,
razon_social VARCHAR(50),
estado VARCHAR(20),
FOREIGN KEY (id) REFERENCES contacto(id)
);

CREATE TABLE tipo_usuario (
  id INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE usuario (
  id INT PRIMARY KEY,
  estado CHAR(1) NOT NULL,
  login VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  id_tipo_usuario INT NOT NULL,
  FOREIGN KEY (id) REFERENCES contacto(id),
  FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id)
);

CREATE TABLE personal (
  id INT PRIMARY KEY,
  estado CHAR(1),
  fecha_contrato DATE ,
  fecha_retiro DATE,
  FOREIGN KEY (id) REFERENCES contacto(id)
);

CREATE TABLE categoria_cliente (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  porcentaje_desc DECIMAL(5,2)
);

CREATE TABLE cliente (
  id INT PRIMARY KEY,
  id_categoria_cliente INT NOT NULL,
  credito_limite DECIMAL(12,2),
  FOREIGN KEY (id) REFERENCES contacto(id),
  FOREIGN KEY (id_categoria_cliente) REFERENCES categoria_cliente(id)
);

CREATE TABLE tipo_catalogo (
    id INTEGER PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE sucursal (
    id SERIAL PRIMARY KEY,
    direccion VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE almacen (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255),
    descripcion VARCHAR(255),
    activo CHAR(1) DEFAULT 'A',
    id_sucursal INTEGER NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id)
);

CREATE TABLE categoria (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE subcategoria (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    id_categoria INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria (id)
);

CREATE TABLE unidad_medida (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    abreviatura VARCHAR(10) NOT NULL
);

CREATE TABLE concepto_ingreso (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE concepto_salida (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE concepto_ajuste (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE concepto_traspaso (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE compra (
  id SERIAL PRIMARY KEY,
  id_personal INT NOT NULL,
  id_almacen INT NOT NULL,
  estado VARCHAR(50),
  fecha DATE,
  tipo_pago CHAR(1),
  id_proveedor INT NOT NULL,
  FOREIGN KEY (id_personal) REFERENCES personal(id),
  FOREIGN KEY (id_almacen) REFERENCES almacen(id),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id)
);

CREATE TABLE ingreso (
    id SERIAL PRIMARY KEY NOT NULL,
    fecha TIMESTAMP NOT NULL,
    costo_transporte NUMERIC(12,2) DEFAULT 0.00,
    costo_carga NUMERIC(12,2) DEFAULT 0.00,
    costo_almacenes NUMERIC(12,2) DEFAULT 0.00,
    otros_costos NUMERIC(12,2) DEFAULT 0.00,
    observaciones VARCHAR(255),
    id_compra INTEGER,
    id_concepto_ingreso INTEGER NOT NULL,
    id_personal INTEGER NOT NULL,
    id_almacen INTEGER NOT NULL,
	FOREIGN KEY (id_compra) REFERENCES compra (id),
	FOREIGN KEY (id_concepto_ingreso) REFERENCES concepto_ingreso (id),
    FOREIGN KEY (id_personal) REFERENCES personal (id),
    FOREIGN KEY (id_almacen) REFERENCES almacen (id)
);


CREATE TABLE catalogo (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    codigo_interno VARCHAR(20) NOT NULL UNIQUE,
    codigo_de_barras VARCHAR(20) UNIQUE,
    codigo_proveedor VARCHAR(20) UNIQUE,
    descripcion VARCHAR(255),
    activo CHAR(1) DEFAULT 'A',
    id_unidad_medida INTEGER NOT NULL,
    id_tipo_catalogo INTEGER NOT NULL,
    id_subcategoria INTEGER NOT NULL,
    FOREIGN KEY (id_unidad_medida) REFERENCES unidad_medida (id),
    FOREIGN KEY (id_tipo_catalogo) REFERENCES tipo_catalogo (id),
    FOREIGN KEY (id_subcategoria) REFERENCES subcategoria (id)
);


CREATE TABLE inventario (
    id_almacen INTEGER NOT NULL,
    id_catalogo INTEGER NOT NULL,
    costo_actual NUMERIC(12,2) NOT NULL DEFAULT 0.00,
    cantidad_actual INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY(id_almacen, id_catalogo),
    FOREIGN KEY (id_almacen) REFERENCES almacen (id),
    FOREIGN KEY (id_catalogo) REFERENCES catalogo (id)
);

CREATE TABLE ingreso_detalle (
    id SERIAL PRIMARY KEY NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 0,
    costo_unitario NUMERIC(12,2) NOT NULL DEFAULT 0.00,
    id_ingreso INTEGER NOT NULL,
    id_catalogo INTEGER NOT NULL,
    FOREIGN KEY (id_ingreso) REFERENCES ingreso (id),
    FOREIGN KEY (id_catalogo) REFERENCES catalogo (id)
);

CREATE TABLE ajuste (
    id SERIAL PRIMARY KEY NOT NULL,
    fecha TIMESTAMP NOT NULL,
    observaciones VARCHAR(255),
    id_almacen INTEGER NOT NULL,
    id_concepto_ajuste INTEGER NOT NULL,
    id_personal INTEGER NOT NULL,
    FOREIGN KEY (id_almacen) REFERENCES almacen (id),
    FOREIGN KEY (id_concepto_ajuste) REFERENCES concepto_ajuste (id),
    FOREIGN KEY (id_personal) REFERENCES personal (id)
);

CREATE TABLE ajuste_detalle (
    id SERIAL PRIMARY KEY NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 0,
    tipo_ajuste CHAR(1) NOT NULL CHECK(tipo_ajuste='S' or tipo_ajuste='R'),
    id_catalogo INTEGER NOT NULL,
    id_ajuste INTEGER NOT NULL,
    FOREIGN KEY (id_catalogo) REFERENCES catalogo (id),
    FOREIGN KEY (id_ajuste) REFERENCES ajuste (id)
);

CREATE TABLE traspaso (
    id SERIAL PRIMARY KEY NOT NULL,
    fecha TIMESTAMP NOT NULL,
    costo_transporte NUMERIC(12,2) DEFAULT 0.00,
    costo_carga NUMERIC(12,2) DEFAULT 0.00,
    costo_almacenes NUMERIC(12,2) DEFAULT 0.00,
    otros_costos NUMERIC(12,2) DEFAULT 0.00,
    observaciones VARCHAR(255),
    id_almacen_origen INTEGER NOT NULL,
    id_almacen_destino INTEGER NOT NULL,
    id_concepto_traspaso INTEGER NOT NULL,
    id_personal INTEGER NOT NULL,
    FOREIGN KEY (id_almacen_origen) REFERENCES almacen (id),
    FOREIGN KEY (id_almacen_destino) REFERENCES almacen (id),
    FOREIGN KEY (id_concepto_traspaso) REFERENCES concepto_traspaso (id),
    FOREIGN KEY (id_personal) REFERENCES personal (id)
);

CREATE TABLE traspaso_detalle (
    id SERIAL PRIMARY KEY NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 0,
    costo_unitario NUMERIC(12,2) NOT NULL DEFAULT 0.00,
    id_catalogo INTEGER NOT NULL,
    id_traspaso INTEGER NOT NULL,
    FOREIGN KEY (id_catalogo) REFERENCES catalogo (id),
    FOREIGN KEY (id_traspaso) REFERENCES traspaso (id)
);

CREATE TABLE salida (
    id SERIAL PRIMARY KEY NOT NULL,
    fecha TIMESTAMP NOT NULL,
    observaciones VARCHAR(255),
    id_personal INTEGER NOT NULL,
    id_concepto_salida INTEGER NOT NULL,
    id_almacen INTEGER NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal (id),
    FOREIGN KEY (id_concepto_salida) REFERENCES concepto_salida (id),
    FOREIGN KEY (id_almacen) REFERENCES almacen (id)
);

CREATE TABLE salida_detalle (
    id SERIAL PRIMARY KEY NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 0,
    costo_unitario NUMERIC(12,2) NOT NULL DEFAULT 0.00,
    id_salida INTEGER NOT NULL,
    id_catalogo INTEGER NOT NULL,
    FOREIGN KEY (id_salida) REFERENCES salida (id),
    FOREIGN KEY (id_catalogo) REFERENCES catalogo (id)
);

CREATE TABLE concepto_cxp (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE concepto_cxc (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE cxp (
  id SERIAL PRIMARY KEY,
  estado CHAR(1),
  fecha_vencimiento DATE,
  fecha_creacion TIMESTAMP,
  id_concepto_cxp INT NOT NULL,
  id_proveedor INT NOT NULL,
  monto_capital DECIMAL(12, 2) NOT NULL,
  monto_pagado DECIMAL(12, 2) NOT NULL,
  deuda_actual DECIMAL(12, 2) NOT NULL,
  id_personal INT NOT NULL,
  FOREIGN KEY (id_concepto_cxp) REFERENCES concepto_cxp(id),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id),
  FOREIGN KEY (id_personal) REFERENCES personal(id)
);

CREATE TABLE cxc (
  id SERIAL PRIMARY KEY,
  id_cliente INT NOT NULL,
  fecha_vencimiento DATE,
  fecha_registro TIMESTAMP,
  deuda_capital DECIMAL(12, 2),
  monto_pagado DECIMAL(12, 2),
  monto_deuda_actual DECIMAL(12, 2),
  id_concepto_cxc INT NOT NULL,
  es_credito CHAR(1) NOT NULL CHECK(es_credito = 'S' or es_credito='N'),
  estado CHAR(1) not null,
  id_personal INT not null,
  FOREIGN KEY (id_concepto_cxc) REFERENCES concepto_cxc(id),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_personal) REFERENCES personal(id)
);

CREATE TABLE credito (
  id SERIAL PRIMARY KEY,
  saldo_actual DECIMAL(12, 2),
  fecha_credito TIMESTAMP,
  estado CHAR(1) not null,
  porcentaje_interes DECIMAL(5, 2),
  plazo_a_meses INT not null,
  id_cxc INT not null,
  id_personal INT not null,
  FOREIGN KEY (id_cxc) REFERENCES cxc(id),
  FOREIGN KEY (id_personal) REFERENCES personal(id)
);

CREATE TABLE cuota (
  id SERIAL PRIMARY KEY,
  id_credito INT NOT NULL,
  fecha_pago DATE NOT NULL,
  interes DECIMAL(12, 2) NOT NULL,
  capital DECIMAL(12, 2) NOT NULL,
  total DECIMAL(12, 2) NOT NULL,
  estado CHAR(1) NOT NULL,
  numero_cuota INT,
  FOREIGN KEY (id_credito) REFERENCES credito(id)
);
CREATE TABLE tipo_activo_fijo (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255)
);

CREATE TABLE activo_fijo (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    fecha_adquisicion DATE,
    costo_adquisicion DECIMAL(12, 2),
    porcentaje_vida_util DECIMAL(5, 2),
    fecha_baja DATE,
    codigo VARCHAR(20) UNIQUE,
    id_sucursal INTEGER REFERENCES sucursal(id) NOT NULL,
    id_tipo_activo_fijo INTEGER REFERENCES tipo_activo_fijo(id) NOT NULL
);

CREATE TABLE caja (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    saldo_inicial DECIMAL(12, 2),
    saldo_actual DECIMAL(12, 2),
    estado CHAR(1)CHECK (estado IN ('A', 'I')),
    observaciones VARCHAR(255),
    fecha_apertura TIMESTAMP,
    id_sucursal INTEGER REFERENCES sucursal(id),
    id_usuario INTEGER REFERENCES usuario(id)
);

CREATE TABLE concepto_movimiento_caja (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255)
);



CREATE TABLE movimiento_caja (
    id SERIAL PRIMARY KEY,
    monto DECIMAL(12, 2),
    fecha TIMESTAMP,
    id_caja INTEGER REFERENCES caja(id),
    descripcion VARCHAR(255),
    id_concepto_movimiento_caja INTEGER REFERENCES concepto_movimiento_caja(id),
    id_contacto INTEGER REFERENCES contacto(id)
);

CREATE TABLE ingreso_caja (
    id SERIAL PRIMARY KEY,
    id_movimiento_caja INTEGER REFERENCES movimiento_caja(id)
);

CREATE TABLE ingreso_cuentas_cobrar (
    id SERIAL PRIMARY KEY,
    id_ingreso_caja INTEGER REFERENCES ingreso_caja(id),
    id_cxc INTEGER REFERENCES cxc(id)
);

CREATE TABLE egreso_caja (
    id SERIAL PRIMARY KEY,
    id_movimiento_caja INTEGER REFERENCES movimiento_caja(id)
);

CREATE TABLE egreso_cuentas_pagar (
    id SERIAL PRIMARY KEY,
    id_egreso_caja INTEGER REFERENCES ingreso_caja(id),
    id_cxp INTEGER REFERENCES cxp(id)
);


CREATE TABLE ingreso_cuotas (
    id SERIAL PRIMARY KEY,
    id_ingreso_caja INTEGER REFERENCES ingreso_caja(id),
    id_cuota INTEGER REFERENCES cuota(id)
);

CREATE TABLE banco (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255)
);

CREATE TABLE cuenta_banco (
    id SERIAL PRIMARY KEY,
    numero_cuenta VARCHAR(20),
    tipo_moneda VARCHAR(50),
    saldo DECIMAL(12, 2),
    titular_contacto INTEGER REFERENCES contacto(id),
    fecha_apertura DATE,
    estado CHAR(1) CHECK (estado IN ('A', 'I')),
    fecha_cierre DATE,
    id_banco INTEGER REFERENCES banco(id)
);




CREATE TABLE concepto_movimiento_banco (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255)
);

CREATE TABLE movimiento_banco (
    id SERIAL PRIMARY KEY,
    monto DECIMAL(12, 2),
    fecha DATE,
    id_cuenta_banco INTEGER REFERENCES cuenta_banco(id),
    id_concepto_movimiento_banco INTEGER REFERENCES concepto_movimiento_banco(id),
    descripcion VARCHAR(255),
    id_usuario INTEGER REFERENCES usuario(id)
);

CREATE TABLE retiro (
    id SERIAL PRIMARY KEY,
    id_movimiento_banco INTEGER REFERENCES movimiento_banco(id)
);


CREATE TABLE deposito (
id SERIAL PRIMARY KEY,
id_movimiento_banco INTEGER REFERENCES movimiento_banco(id)
);

CREATE TABLE cierre_caja (
id SERIAL PRIMARY KEY,
fecha TIMESTAMP,
id_caja INTEGER REFERENCES caja(id),
monto_efectivo DECIMAL(12, 2),
monto_sistema DECIMAL(12, 2),
id_usuario INTEGER REFERENCES usuario(id),
observaciones VARCHAR(255)
);

CREATE TABLE proforma (
  id SERIAL PRIMARY KEY,
  id_cliente INT NOT NULL,
  id_personal INT NOT NULL,
  id_almacen INT NOT NULL,
  fecha TIMESTAMP,
  dias_valido INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_personal) REFERENCES personal(id)
);

CREATE TABLE detalle_proforma (
  id SERIAL PRIMARY KEY,
  id_proforma INT NOT NULL,
  id_catalogo INT NOT NULL,
  cantidad INT NOT NULL,
  precio DECIMAL(12,2),
  FOREIGN KEY (id_proforma) REFERENCES proforma(id),
  FOREIGN KEY (id_catalogo) REFERENCES catalogo(id)
);
CREATE TABLE venta (
  id SERIAL PRIMARY KEY,
  id_cliente INT NOT NULL,
  id_personal INT NOT NULL,
  id_almacen INT NOT NULL,
  fecha TIMESTAMP,
  tipo_pago CHAR(1) NOT NULL,
  observaciones VARCHAR(255),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_personal) REFERENCES personal(id),
  FOREIGN KEY (id_almacen) REFERENCES almacen(id)
);

CREATE TABLE detalle_venta (
  id SERIAL PRIMARY KEY,
  id_venta INT NOT NULL,
  id_catalogo INT NOT NULL,
  cantidad INT NOT NULL,
  precio DECIMAL(12,2),
  costo DECIMAL(12,2),
  FOREIGN KEY (id_venta) REFERENCES venta(id),
  FOREIGN KEY (id_catalogo) REFERENCES catalogo(id)
);

CREATE TABLE lista_precio (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  fecha_inicial DATE,
  fecha_expiracion DATE,
  estado CHAR(1),
  id_personal INT NOT NULL,
  FOREIGN KEY (id_personal) REFERENCES personal(id)
);

CREATE TABLE detalle_lista (
  id SERIAL PRIMARY KEY,
  id_catalogo INT NOT NULL,
  id_lista_precio INT NOT NULL,
  precio DECIMAL(12,2),
  FOREIGN KEY (id_catalogo) REFERENCES catalogo(id),
  FOREIGN KEY (id_lista_precio) REFERENCES lista_precio(id)
);

CREATE TABLE detalle_compra (
  id SERIAL PRIMARY KEY,
  id_catalogo INT NOT NULL,
  id_compra INT NOT NULL,
  precio DECIMAL(12, 2),
  cantidad INT,
  FOREIGN KEY (id_catalogo) REFERENCES catalogo(id),
  FOREIGN KEY (id_compra) REFERENCES compra(id)
); 