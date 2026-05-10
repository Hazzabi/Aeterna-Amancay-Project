/*
------- SCRIPT CREACION DE TABLAS - AETERNA AMANCAY -------
------------------ GABRIELA GARCIA 1ASIR ----------------
*/

CREATE TABLE sedes (
    id_sede SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(255),
    ubicacion VARCHAR(150),
    telefono_emergencia VARCHAR(20),
    tipo VARCHAR(50)
);

CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,
    id_sede INT REFERENCES sedes(id_sede) ON DELETE SET NULL,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(100),
    departamento_ou VARCHAR(50),
    email_corp VARCHAR(100) UNIQUE,
    fecha_incorporacion DATE DEFAULT CURRENT_DATE
);

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre_fiscal VARCHAR(150) NOT NULL,
    nif_cif VARCHAR(20) UNIQUE NOT NULL,
    contacto_principal VARCHAR(100),
    email_contacto VARCHAR(100),
    pais_jurisdiccion VARCHAR(50)
);

CREATE TABLE cuentas_acceso (
    id_cuenta SERIAL PRIMARY KEY,
    id_empleado INT REFERENCES empleados(id_empleado) ON DELETE CASCADE,
    id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    sal_seguridad VARCHAR(100),
    estado VARCHAR(20) DEFAULT 'Activa',
    ultimo_login TIMESTAMP,
    CONSTRAINT chk_cuenta_tipo CHECK (
        (id_empleado IS NOT NULL AND id_cliente IS NULL) OR
        (id_empleado IS NULL AND id_cliente IS NOT NULL)
    )
);

CREATE TABLE log_seguridad (
    id_log SERIAL PRIMARY KEY,
    id_cuenta INT REFERENCES cuentas_acceso(id_cuenta) ON DELETE CASCADE,
    accion VARCHAR(100),
    ip_origen INET,
    navegador_agente TEXT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE contratos (
    id_contrato SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    titulo VARCHAR(200) NOT NULL,
    fecha_firma DATE,
    fecha_fin DATE,
    presupuesto_total DECIMAL(18,2),
    clausula_confidencialidad BOOLEAN DEFAULT TRUE
);

CREATE TABLE facturas (
    id_factura SERIAL PRIMARY KEY,
    id_contrato INT REFERENCES contratos(id_contrato) ON DELETE CASCADE,
    numero_factura VARCHAR(50) UNIQUE NOT NULL,
    fecha_emision DATE DEFAULT CURRENT_DATE,
    estado_pago VARCHAR(20)
);

CREATE TABLE linea_factura (
    id_linea SERIAL PRIMARY KEY,
    id_factura INT REFERENCES facturas(id_factura) ON DELETE CASCADE,
    concepto TEXT NOT NULL,
    cantidad INT DEFAULT 1,
    precio_unitario DECIMAL(15,2) NOT NULL,
    impuestos_aplicados DECIMAL(5,2) DEFAULT 0.00
);

CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    id_factura INT REFERENCES facturas(id_factura) ON DELETE CASCADE,
    metodo_pago VARCHAR(50),
    referencia_transaccion VARCHAR(100),
    monto_pagado DECIMAL(15,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE proyectos (
    id_proyecto SERIAL PRIMARY KEY,
    id_contrato INT REFERENCES contratos(id_contrato) ON DELETE CASCADE,
    nombre_proyecto VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fase_actual VARCHAR(50),
    prioridad_mision INT CHECK (prioridad_mision BETWEEN 1 AND 5),
    fecha_inicio DATE,
    estado VARCHAR(50)
);

CREATE TABLE satelites (
    id_satelite SERIAL PRIMARY KEY,
    id_proyecto INT REFERENCES proyectos(id_proyecto) ON DELETE CASCADE,
    nombre_satelite VARCHAR(50) UNIQUE NOT NULL,
    modelo_motor VARCHAR(100),
    frecuencia_transmision VARCHAR(50),
    peso_kg DECIMAL(10,2),
    estado VARCHAR(50)
);

CREATE TABLE misiones_despegue (
    id_despegue SERIAL PRIMARY KEY,
    id_proyecto INT REFERENCES proyectos(id_proyecto) ON DELETE CASCADE,
    id_satelite INT REFERENCES satelites(id_satelite) ON DELETE SET NULL,
    ventana_lanzamiento TIMESTAMP,
    plataforma_lanzamiento VARCHAR(100),
    lanzador VARCHAR(50),
    resultado_lanzamiento VARCHAR(50)
);

CREATE TABLE telemetria_espejo (
    id_dato SERIAL PRIMARY KEY,
    id_satelite INT REFERENCES satelites(id_satelite) ON DELETE CASCADE,
    altitud_km DECIMAL(10,3),
    velocidad_ms DECIMAL(10,3),
    temperatura_exterior DECIMAL(5,2),
    nivel_energia_solar INT,
    energia NUMERIC(10,2),
    timestamp_captura TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE incidencias_espaciales (
    id_incidencia SERIAL PRIMARY KEY,
    id_satelite INT REFERENCES satelites(id_satelite) ON DELETE CASCADE,
    id_empleado_asignado INT REFERENCES empleados(id_empleado) ON DELETE SET NULL,
    descripcion TEXT NOT NULL,
    nivel_gravedad VARCHAR(20),
    estado_resolucion VARCHAR(50),
    fecha_incidencia DATE DEFAULT CURRENT_DATE
);

CREATE TABLE categorias_material (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    normativa_seguridad TEXT
);

CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_empresa VARCHAR(150) NOT NULL,
    especialidad VARCHAR(100),
    calificacion_calidad INT CHECK (calificacion_calidad BETWEEN 1 AND 10),
    pais VARCHAR(100)
);

CREATE TABLE stock_almacen (
    id_material SERIAL PRIMARY KEY,
    id_sede INT REFERENCES sedes(id_sede) ON DELETE SET NULL,
    id_categoria INT REFERENCES categorias_material(id_categoria) ON DELETE SET NULL,
    id_proveedor INT REFERENCES proveedores(id_proveedor) ON DELETE SET NULL,
    nombre_material VARCHAR(100) NOT NULL,
    cantidad_disponible INT DEFAULT 0,
    punto_pedido INT
);

CREATE TABLE consumo_material (
    id_consumo SERIAL PRIMARY KEY,
    id_proyecto INT REFERENCES proyectos(id_proyecto) ON DELETE CASCADE,
    id_material INT REFERENCES stock_almacen(id_material) ON DELETE CASCADE,
    cantidad_usada INT NOT NULL,
    fecha_extraccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE proyecto_empleado (
    id_proyecto INT REFERENCES proyectos(id_proyecto) ON DELETE CASCADE,
    id_empleado INT REFERENCES empleados(id_empleado) ON DELETE CASCADE,
    rol_en_proyecto VARCHAR(100),
    horas_asignadas INT,
    PRIMARY KEY (id_proyecto, id_empleado)
);

CREATE TABLE mision_satelite (
    id_despegue INT REFERENCES misiones_despegue(id_despegue) ON DELETE CASCADE,
    id_satelite INT REFERENCES satelites(id_satelite) ON DELETE CASCADE,
    PRIMARY KEY (id_despegue, id_satelite)
);

CREATE TABLE incidencia_empleado (
    id_incidencia INT REFERENCES incidencias_espaciales(id_incidencia) ON DELETE CASCADE,
    id_empleado INT REFERENCES empleados(id_empleado) ON DELETE CASCADE,
    rol VARCHAR(50),
    PRIMARY KEY (id_incidencia, id_empleado)
);

CREATE TABLE componentes_satelite (
    id_satelite INT REFERENCES satelites(id_satelite) ON DELETE CASCADE,
    id_material INT REFERENCES stock_almacen(id_material) ON DELETE CASCADE,
    cantidad_usada INT NOT NULL,
    fecha_instalacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_satelite, id_material)
);