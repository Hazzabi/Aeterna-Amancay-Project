
/*
------- SCRIPT INSERCION DE DATOS - AETERNA AMANCAY -------
------------------ GABRIELA GARCIA 1ASIR ----------------
*/

INSERT INTO sedes (id_sede, nombre, direccion, ubicacion, telefono_emergencia, tipo) VALUES
    (1, 'Alborada', 'Calle Boreal 11', 'Madrid, ES', '+34-910-000-111', 'Sede'),
    (2, 'El Santuario', 'Parque Orbital 7', 'Sevilla, ES', '+34-955-200-333', 'Sede'),
    (3, 'Nexo de Control', 'Avenida Antares 42', 'Valencia, ES', '+34-960-777-999', 'Centro Operaciones');

INSERT INTO empleados (id_empleado, id_sede, nombre, puesto, departamento_ou, email_corp, fecha_incorporacion) VALUES
    (1, 1, 'Irene Valdes', 'Directora de Mision', 'Direccion', 'irene.valdes@aeterna.local', '2021-02-10'),
    (2, 1, 'Hugo Marin', 'Ingeniero Astral', 'Ingenieria', 'hugo.marin@aeterna.local', '2022-06-01'),
    (3, 2, 'Lina Ortega', 'Guardian del Eter', 'Seguridad', 'lina.ortega@aeterna.local', '2023-01-17'),
    (4, 2, 'Rocio Nieto', 'Analista de Telemetria', 'Control', 'rocio.nieto@aeterna.local', '2023-04-03'),
    (5, 3, 'Pablo Sierra', 'Tecnico de Integracion', 'Montaje', 'pablo.sierra@aeterna.local', '2024-09-20'),
    (6, 3, 'Nora Fuentes', 'Responsable Financiera', 'Administracion', 'nora.fuentes@aeterna.local', '2022-11-08');

INSERT INTO clientes (id_cliente, nombre_fiscal, nif_cif, contacto_principal, email_contacto, pais_jurisdiccion) VALUES
    (1, 'Ministerio de Ciencia de Espana', 'ESQ2801234A', 'Alvaro Mena', 'alvaro.mena@ciencia.gob.es', 'Espana'),
    (2, 'GeoScan Analytics SL', 'B76321459', 'Marta Cifuentes', 'marta@geoscan.es', 'Espana'),
    (3, 'NorthSky Dynamics', 'US88492A120', 'Olivia Chen', 'olivia.chen@northsky.us', 'Estados Unidos'),
    (4, 'Orbital Agro Labs', 'PT508773321', 'Tiago Ribeiro', 'tiago@orbitalagro.pt', 'Portugal');

INSERT INTO cuentas_acceso (id_cuenta, id_empleado, id_cliente, username, password_hash, sal_seguridad, estado, ultimo_login) VALUES
    (1, 1, NULL, 'ivaldes', 'hash_emp_01', 'salt_emp_01', 'Activa', '2026-04-20 08:15:10'),
    (2, 2, NULL, 'hmarin', 'hash_emp_02', 'salt_emp_02', 'Activa', '2026-04-21 10:42:33'),
    (3, 3, NULL, 'lortega', 'hash_emp_03', 'salt_emp_03', 'Bloqueada', '2026-04-18 06:59:01'),
    (4, 4, NULL, 'rnieto', 'hash_emp_04', 'salt_emp_04', 'Activa', '2026-04-22 22:10:44'),
    (5, 5, NULL, 'psierra', 'hash_emp_05', 'salt_emp_05', 'Activa', '2026-04-22 17:03:12'),
    (6, 6, NULL, 'nfuentes', 'hash_emp_06', 'salt_emp_06', 'Activa', '2026-04-23 07:31:08'),
    (7, NULL, 1, 'mciencia', 'hash_cli_01', 'salt_cli_01', 'Activa', '2026-04-20 11:11:11'),
    (8, NULL, 2, 'geoscan', 'hash_cli_02', 'salt_cli_02', 'Activa', '2026-04-19 09:01:30'),
    (9, NULL, 3, 'northsky', 'hash_cli_03', 'salt_cli_03', 'Activa', '2026-04-22 14:21:02'),
    (10, NULL, 4, 'oagrolabs', 'hash_cli_04', 'salt_cli_04', 'Activa', '2026-04-17 19:48:55');

INSERT INTO log_seguridad (id_log, id_cuenta, accion, ip_origen, navegador_agente, fecha_hora) VALUES
    (1, 1, 'Login', '172.16.10.21', 'Firefox 135', '2026-04-20 08:15:11'),
    (2, 3, 'Intento fallido', '172.16.10.31', 'Edge 124', '2026-04-20 08:16:09'),
    (3, 7, 'Consulta Factura', '81.44.17.90', 'Chrome 124', '2026-04-21 12:04:22'),
    (4, 9, 'Descarga Contrato', '104.28.56.18', 'Safari 18', '2026-04-22 14:33:40'),
    (5, 6, 'Cambio de clave', '172.16.10.44', 'Firefox 135', '2026-04-23 07:40:03');

INSERT INTO contratos (id_contrato, id_cliente, titulo, fecha_firma, fecha_fin, presupuesto_total, clausula_confidencialidad) VALUES
    (1, 1, 'Programa Atlas CubeSat 2026', '2025-03-15', '2027-12-31', 4800000.00, TRUE),
    (2, 2, 'Monitorizacion Costera Helios', '2025-11-02', '2026-11-30', 1350000.00, TRUE),
    (3, 3, 'Constelacion Polaris-Edge', '2026-01-20', '2028-01-31', 7200000.00, TRUE),
    (4, 4, 'AgroSense Orbital Iberia', '2026-02-10', '2027-09-30', 2150000.00, TRUE);

INSERT INTO facturas (id_factura, id_contrato, numero_factura, fecha_emision, estado_pago) VALUES
    (1, 1, 'FAC-2026-0001', '2026-01-05', 'Cobrado'),
    (2, 1, 'FAC-2026-0012', '2026-03-01', 'Pendiente'),
    (3, 2, 'FAC-2026-0020', '2026-02-11', 'Cobrado'),
    (4, 3, 'FAC-2026-0033', '2026-03-19', 'Pendiente'),
    (5, 4, 'FAC-2026-0040', '2026-04-02', 'Pendiente');

INSERT INTO linea_factura (id_linea, id_factura, concepto, cantidad, precio_unitario, impuestos_aplicados) VALUES
    (1, 1, 'Hito inicial de arquitectura', 1, 550000.00, 21.00),
    (2, 1, 'Integracion de carga util', 2, 120000.00, 21.00),
    (3, 2, 'Ensayos termicos orbitales', 1, 300000.00, 21.00),
    (4, 3, 'Tasas de lanzamiento', 1, 430000.00, 21.00),
    (5, 4, 'Fabricacion de bus satelital', 1, 890000.00, 21.00),
    (6, 5, 'Paquete de sensores hiperespectrales', 3, 175000.00, 21.00);

INSERT INTO pagos (id_pago, id_factura, metodo_pago, referencia_transaccion, monto_pagado, fecha_pago) VALUES
    (1, 1, 'Transferencia', 'TRX-ES-MCI-8891', 955900.00, '2026-01-18 10:20:00'),
    (2, 3, 'Credito gubernamental', 'TRX-ES-GEO-1012', 520300.00, '2026-02-21 16:41:00'),
    (3, 1, 'Transferencia', 'TRX-ES-MCI-9300', 250000.00, '2026-02-12 09:11:00');

INSERT INTO proyectos (id_proyecto, id_contrato, nombre_proyecto, descripcion, fase_actual, prioridad_mision, fecha_inicio, estado) VALUES
    (1, 1, 'Atlas-1', 'Despliegue de satelite de observacion institucional', 'Construccion', 5, '2025-04-01', 'Activo'),
    (2, 2, 'Helios-Coast', 'Seguimiento maritimo y analitica costera', 'Orbita', 4, '2025-12-01', 'Activo'),
    (3, 3, 'Polaris-Edge', 'Constelacion de baja latencia para telemetria', 'Diseno', 5, '2026-02-01', 'Activo'),
    (4, 4, 'AgroSense-Iberia', 'Servicios de teledeteccion agricola', 'Construccion', 3, '2026-02-20', 'En pausa');

INSERT INTO satelites (id_satelite, id_proyecto, nombre_satelite, modelo_motor, frecuencia_transmision, peso_kg, estado) VALUES
    (1, 1, 'CONSTELACION-01', 'Aurora-I', '8.2 GHz', 185.40, 'En orbita'),
    (2, 1, 'CONSTELACION-02', 'Aurora-I', '8.2 GHz', 189.10, 'En construccion'),
    (3, 2, 'HELIOS-ALFA', 'Solsticio-X', '7.4 GHz', 210.00, 'En orbita'),
    (4, 3, 'POLARIS-01', 'Aurora-I', '9.1 GHz', 198.30, 'En construccion'),
    (5, 4, 'AGRO-ORBIT-01', 'Solsticio-X', '6.8 GHz', 172.50, 'En construccion');

INSERT INTO misiones_despegue (id_despegue, id_proyecto, id_satelite, ventana_lanzamiento, plataforma_lanzamiento, lanzador, resultado_lanzamiento) VALUES
    (1, 1, 1, '2026-01-27 06:30:00', 'El Santuario', 'Aurora-I', 'Exito total'),
    (2, 2, 3, '2026-02-14 09:10:00', 'Alborada', 'Solsticio-X', 'Exito total'),
    (3, 3, 4, '2026-08-03 05:45:00', 'El Santuario', 'Aurora-I', 'Parcial'),
    (4, 4, 5, '2026-09-11 07:20:00', 'Nexo de Control', 'Solsticio-X', 'Pendiente');

INSERT INTO telemetria_espejo (id_dato, id_satelite, altitud_km, velocidad_ms, temperatura_exterior, nivel_energia_solar, energia, timestamp_captura) VALUES
    (1, 1, 542.120, 7612.450, -12.40, 84, 145.20, '2026-04-23 08:00:00'),
    (2, 1, 542.250, 7611.982, -11.90, 82, 143.10, '2026-04-23 08:05:00'),
    (3, 3, 610.840, 7488.331, -18.20, 77, 139.80, '2026-04-23 08:00:00'),
    (4, 3, 611.010, 7487.929, -17.70, 76, 138.90, '2026-04-23 08:05:00'),
    (5, 4, 503.600, 7722.180, -8.50, 63, 120.40, '2026-04-23 08:00:00'),
    (6, 5, 490.430, 7810.004, -5.20, 58, 115.75, '2026-04-23 08:00:00');

INSERT INTO incidencias_espaciales (id_incidencia, id_satelite, id_empleado_asignado, descripcion, nivel_gravedad, estado_resolucion, fecha_incidencia) VALUES
    (1, 3, 4, 'Picos de temperatura en modulo de potencia', 'Media', 'En progreso', '2026-04-20'),
    (2, 1, 2, 'Variacion anomala en telemetria de velocidad', 'Baja', 'Abierta', '2026-04-21'),
    (3, 4, 3, 'Perdida intermitente de enlace seguro', 'Critica', 'En progreso', '2026-04-22');

INSERT INTO categorias_material (id_categoria, nombre_categoria, normativa_seguridad) VALUES
    (1, 'Estructura', 'ISO-14644 y control de particulas'),
    (2, 'Motores', 'Protocolo de propulsion segura EPS-19'),
    (3, 'Electronica', 'Norma EMC-SPACE-77'),
    (4, 'Sensores', 'Calibracion CEN-ORBIT-04');

INSERT INTO proveedores (id_proveedor, nombre_empresa, especialidad, calificacion_calidad, pais) VALUES
    (1, 'TitanForge GmbH', 'Aleaciones aeroespaciales', 9, 'Alemania'),
    (2, 'NovaCircuits SA', 'Placas y electronica espacial', 8, 'Francia'),
    (3, 'Helix Propulsion Ltd', 'Sistemas de propulsion compacta', 9, 'Reino Unido'),
    (4, 'Iberia Optics Tech', 'Sensores opticos y termicos', 7, 'Espana');

INSERT INTO stock_almacen (id_material, id_sede, id_categoria, id_proveedor, nombre_material, cantidad_disponible, punto_pedido) VALUES
    (1, 1, 1, 1, 'Panel titanio T-98', 320, 100),
    (2, 1, 3, 2, 'PCB rad-hard R12', 140, 40),
    (3, 2, 2, 3, 'Micropropulsor AX-5', 48, 15),
    (4, 2, 4, 4, 'Sensor termico ST-9', 210, 60),
    (5, 3, 3, 2, 'Controlador de vuelo CF-4', 75, 20),
    (6, 3, 1, 1, 'Tornillo titanio M4', 5000, 1000);

INSERT INTO consumo_material (id_consumo, id_proyecto, id_material, cantidad_usada, fecha_extraccion) VALUES
    (1, 1, 1, 40, '2026-03-01 09:00:00'),
    (2, 1, 2, 18, '2026-03-02 11:30:00'),
    (3, 2, 3, 6, '2026-03-05 14:10:00'),
    (4, 3, 5, 10, '2026-03-07 10:45:00'),
    (5, 4, 4, 12, '2026-03-09 16:20:00'),
    (6, 4, 6, 400, '2026-03-10 08:10:00');

INSERT INTO proyecto_empleado (id_proyecto, id_empleado, rol_en_proyecto, horas_asignadas) VALUES
    (1, 1, 'Directora tecnica', 120),
    (1, 2, 'Ingeniero lider', 160),
    (1, 5, 'Integracion de modulos', 140),
    (2, 4, 'Analista principal', 150),
    (2, 3, 'Ciberseguridad orbital', 90),
    (3, 2, 'Arquitectura de propulsion', 130),
    (3, 3, 'Seguridad de comunicaciones', 110),
    (4, 6, 'Control financiero', 70);

INSERT INTO mision_satelite (id_despegue, id_satelite) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5);

INSERT INTO incidencia_empleado (id_incidencia, id_empleado, rol) VALUES
    (1, 4, 'Diagnostico'),
    (1, 2, 'Supervision'),
    (2, 2, 'Diagnostico'),
    (3, 3, 'Diagnostico'),
    (3, 4, 'Reparacion');

INSERT INTO componentes_satelite (id_satelite, id_material, cantidad_usada, fecha_instalacion) VALUES
    (1, 1, 12, '2026-01-10 10:00:00'),
    (1, 2, 4, '2026-01-11 12:00:00'),
    (2, 1, 10, '2026-04-01 09:00:00'),
    (3, 3, 2, '2026-01-20 15:30:00'),
    (3, 4, 6, '2026-01-20 16:10:00'),
    (4, 5, 3, '2026-03-15 11:40:00'),
    (5, 4, 5, '2026-03-20 17:45:00');

    
 /* -- setval para sincronizar las secuencias seriales con los id insertados manualmente 
 para evitar colisiones en futuras inserciones*/


SELECT setval(pg_get_serial_sequence('sedes', 'id_sede'), COALESCE((SELECT MAX(id_sede) FROM sedes), 1), true);
SELECT setval(pg_get_serial_sequence('empleados', 'id_empleado'), COALESCE((SELECT MAX(id_empleado) FROM empleados), 1), true);
SELECT setval(pg_get_serial_sequence('clientes', 'id_cliente'), COALESCE((SELECT MAX(id_cliente) FROM clientes), 1), true);
SELECT setval(pg_get_serial_sequence('cuentas_acceso', 'id_cuenta'), COALESCE((SELECT MAX(id_cuenta) FROM cuentas_acceso), 1), true);
SELECT setval(pg_get_serial_sequence('log_seguridad', 'id_log'), COALESCE((SELECT MAX(id_log) FROM log_seguridad), 1), true);
SELECT setval(pg_get_serial_sequence('contratos', 'id_contrato'), COALESCE((SELECT MAX(id_contrato) FROM contratos), 1), true);
SELECT setval(pg_get_serial_sequence('facturas', 'id_factura'), COALESCE((SELECT MAX(id_factura) FROM facturas), 1), true);
SELECT setval(pg_get_serial_sequence('linea_factura', 'id_linea'), COALESCE((SELECT MAX(id_linea) FROM linea_factura), 1), true);
SELECT setval(pg_get_serial_sequence('pagos', 'id_pago'), COALESCE((SELECT MAX(id_pago) FROM pagos), 1), true);
SELECT setval(pg_get_serial_sequence('proyectos', 'id_proyecto'), COALESCE((SELECT MAX(id_proyecto) FROM proyectos), 1), true);
SELECT setval(pg_get_serial_sequence('satelites', 'id_satelite'), COALESCE((SELECT MAX(id_satelite) FROM satelites), 1), true);
SELECT setval(pg_get_serial_sequence('misiones_despegue', 'id_despegue'), COALESCE((SELECT MAX(id_despegue) FROM misiones_despegue), 1), true);
SELECT setval(pg_get_serial_sequence('telemetria_espejo', 'id_dato'), COALESCE((SELECT MAX(id_dato) FROM telemetria_espejo), 1), true);
SELECT setval(pg_get_serial_sequence('incidencias_espaciales', 'id_incidencia'), COALESCE((SELECT MAX(id_incidencia) FROM incidencias_espaciales), 1), true);
SELECT setval(pg_get_serial_sequence('categorias_material', 'id_categoria'), COALESCE((SELECT MAX(id_categoria) FROM categorias_material), 1), true);
SELECT setval(pg_get_serial_sequence('proveedores', 'id_proveedor'), COALESCE((SELECT MAX(id_proveedor) FROM proveedores), 1), true);
SELECT setval(pg_get_serial_sequence('stock_almacen', 'id_material'), COALESCE((SELECT MAX(id_material) FROM stock_almacen), 1), true);
SELECT setval(pg_get_serial_sequence('consumo_material', 'id_consumo'), COALESCE((SELECT MAX(id_consumo) FROM consumo_material), 1), true);

COMMIT;