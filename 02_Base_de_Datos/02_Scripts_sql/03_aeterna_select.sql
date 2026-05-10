
/*
------- SCRIPT DE EXTRACCION DE DATOS - AETERNA AMANCAY -------
------------------ GABRIELA GARCIA 1ASIR ----------------
*/

SELECT 'sedes' AS tabla, COUNT(*) AS total FROM sedes
UNION ALL SELECT 'empleados', COUNT(*) FROM empleados
UNION ALL SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL SELECT 'cuentas_acceso', COUNT(*) FROM cuentas_acceso
UNION ALL SELECT 'log_seguridad', COUNT(*) FROM log_seguridad
UNION ALL SELECT 'contratos', COUNT(*) FROM contratos
UNION ALL SELECT 'facturas', COUNT(*) FROM facturas
UNION ALL SELECT 'linea_factura', COUNT(*) FROM linea_factura
UNION ALL SELECT 'pagos', COUNT(*) FROM pagos
UNION ALL SELECT 'proyectos', COUNT(*) FROM proyectos
UNION ALL SELECT 'satelites', COUNT(*) FROM satelites
UNION ALL SELECT 'misiones_despegue', COUNT(*) FROM misiones_despegue
UNION ALL SELECT 'telemetria_espejo', COUNT(*) FROM telemetria_espejo
UNION ALL SELECT 'incidencias_espaciales', COUNT(*) FROM incidencias_espaciales
UNION ALL SELECT 'categorias_material', COUNT(*) FROM categorias_material
UNION ALL SELECT 'proveedores', COUNT(*) FROM proveedores
UNION ALL SELECT 'stock_almacen', COUNT(*) FROM stock_almacen
UNION ALL SELECT 'consumo_material', COUNT(*) FROM consumo_material
UNION ALL SELECT 'proyecto_empleado', COUNT(*) FROM proyecto_empleado
UNION ALL SELECT 'mision_satelite', COUNT(*) FROM mision_satelite
UNION ALL SELECT 'incidencia_empleado', COUNT(*) FROM incidencia_empleado
UNION ALL SELECT 'componentes_satelite', COUNT(*) FROM componentes_satelite
ORDER BY tabla;

SELECT
    c.id_cliente,
    c.nombre_fiscal,
    COUNT(ct.id_contrato) AS contratos,
    COALESCE(SUM(ct.presupuesto_total), 0) AS presupuesto_acumulado
FROM clientes c
LEFT JOIN contratos ct ON ct.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_fiscal
ORDER BY presupuesto_acumulado DESC;

SELECT
    ct.id_contrato,
    ct.titulo,
    f.numero_factura,
    f.estado_pago,
    COALESCE(SUM(lf.cantidad * lf.precio_unitario * (1 + lf.impuestos_aplicados / 100.0)), 0) AS total_factura_con_impuestos
FROM contratos ct
JOIN facturas f ON f.id_contrato = ct.id_contrato
LEFT JOIN linea_factura lf ON lf.id_factura = f.id_factura
GROUP BY ct.id_contrato, ct.titulo, f.numero_factura, f.estado_pago
ORDER BY ct.id_contrato, f.numero_factura;

SELECT DISTINCT ON (s.id_satelite)
    s.id_satelite,
    s.nombre_satelite,
    t.altitud_km,
    t.velocidad_ms,
    t.temperatura_exterior,
    t.nivel_energia_solar,
    t.timestamp_captura
FROM satelites s
JOIN telemetria_espejo t ON t.id_satelite = s.id_satelite
ORDER BY s.id_satelite, t.timestamp_captura DESC;

SELECT
    i.id_incidencia,
    s.nombre_satelite,
    e.nombre AS empleado_asignado,
    i.nivel_gravedad,
    i.estado_resolucion,
    i.fecha_incidencia
FROM incidencias_espaciales i
LEFT JOIN satelites s ON s.id_satelite = i.id_satelite
LEFT JOIN empleados e ON e.id_empleado = i.id_empleado_asignado
WHERE i.estado_resolucion IN ('Abierta', 'En progreso')
ORDER BY i.fecha_incidencia DESC;

SELECT
    sa.id_material,
    sa.nombre_material,
    sa.cantidad_disponible,
    sa.punto_pedido,
    (sa.cantidad_disponible - sa.punto_pedido) AS margen_stock,
    p.nombre_empresa AS proveedor
FROM stock_almacen sa
LEFT JOIN proveedores p ON p.id_proveedor = sa.id_proveedor
WHERE sa.cantidad_disponible <= sa.punto_pedido
ORDER BY margen_stock ASC;

