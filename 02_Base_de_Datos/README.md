# Base de Datos Aeterna Amancay

Este proyecto contiene la base de datos relacional de **Aeterna Amancay**. La idea principal es guardar la informacion importante de la empresa: empleados, clientes, contratos, facturas, satelites, misiones, telemetria, incidencias e inventario.

Lo he organizado de forma que sea facil encontrar cada parte del trabajo: la memoria, los scripts SQL y el diagrama entidad-relacion.

## Estructura del proyecto

```text
02_Base_de_Datos/
|-- 01_Memoria_BBDD_Amancay.docx
|-- 02_Scripts_sql/
|   |-- 01_aeterna_create.sql
|   |-- 02_aeterna_insert.sql
|   `-- 03_aeterna_select.sql
`-- 03_Diagramas/
    `-- AMANCAY E-R.png
```

## Memoria del proyecto

El archivo `01_Memoria_BBDD_Amancay.pdf` es el documento principal donde se explica el diseño de la base de datos. En la memoria se habla del objetivo del proyecto, de como se han separado las tablas y de por que se usan claves primarias, claves foraneas y relaciones entre tablas.

Tambien se explica que la base de datos esta pensada para cumplir la tercera forma normal, evitando repetir datos innecesariamente.

## Como estan divididos los temas

La base de datos esta dividida en 4 bloques principales:

### 1. Infraestructura y seguridad

Aqui se guarda la informacion relacionada con el acceso al sistema.

Tablas principales:

- `sedes`
- `empleados`
- `clientes`
- `cuentas_acceso`
- `log_seguridad`

Este bloque sirve para saber que empleados y clientes existen, que cuentas tienen y que acciones hacen dentro del sistema.

### 2. Administracion y facturacion

Este bloque se encarga de la parte economica de la empresa.

Tablas principales:

- `contratos`
- `facturas`
- `linea_factura`
- `pagos`

Con estas tablas se pueden controlar los contratos con los clientes, las facturas emitidas, los conceptos de cada factura y los pagos realizados.

### 3. Operaciones espaciales

Esta es la parte mas tecnica del proyecto, porque guarda datos de proyectos, satelites, lanzamientos e incidencias.

Tablas principales:

- `proyectos`
- `satelites`
- `misiones_despegue`
- `telemetria_espejo`
- `incidencias_espaciales`

Sirve para controlar que satelites pertenecen a cada proyecto, que misiones de despegue hay, que datos de telemetria se reciben y que problemas se han detectado.

### 4. Inventario y suministros

Este bloque controla los materiales que se usan para construir o mantener los satelites.

Tablas principales:

- `categorias_material`
- `proveedores`
- `stock_almacen`
- `consumo_material`

Aqui se puede ver que materiales hay en almacen, quien los suministra, en que sede estan y cuanto se ha usado en cada proyecto.

## Tablas intermedias

Tambien hay tablas intermedias para representar relaciones de muchos a muchos. Esto significa que un registro puede estar relacionado con varios de otra tabla.

Las tablas intermedias son:

- `proyecto_empleado`: relaciona proyectos con empleados.
- `mision_satelite`: relaciona misiones con satelites.
- `incidencia_empleado`: relaciona incidencias con empleados.
- `componentes_satelite`: relaciona satelites con materiales usados.

Estas tablas ayudan a que la base de datos sea mas ordenada y no se repita informacion.

## Scripts SQL

Los scripts se encuentran dentro de la carpeta `02_Scripts_sql`.

### `01_aeterna_create.sql`

Este script crea todas las tablas de la base de datos.

Incluye:

- Claves primarias.
- Claves foraneas.
- Restricciones `CHECK`.
- Relaciones entre tablas.
- Politicas como `ON DELETE CASCADE` y `ON DELETE SET NULL`.

Es el primer script que se debe ejecutar.

### `02_aeterna_insert.sql`

Este script inserta datos de prueba en las tablas.

Incluye ejemplos de:

- Sedes.
- Empleados.
- Clientes.
- Cuentas de acceso.
- Contratos.
- Facturas.
- Pagos.
- Proyectos.
- Satelites.
- Misiones.
- Telemetria.
- Incidencias.
- Materiales y proveedores.

Tambien actualiza las secuencias `SERIAL` con `setval`, para que no haya problemas si luego se insertan mas datos.

### `03_aeterna_select.sql`

Este script contiene consultas para comprobar que la base de datos funciona bien.

Las consultas sirven para:

- Contar cuantos registros tiene cada tabla.
- Ver los clientes con sus contratos y presupuesto total.
- Revisar el estado de las facturas.
- Obtener la ultima telemetria de cada satelite.
- Ver incidencias abiertas o en progreso.
- Detectar materiales con poco stock.

## Diagrama

En la carpeta `03_Diagramas` esta el archivo `AMANCAY E-R.png`.

Ese diagrama muestra visualmente las tablas y sus relaciones. Es util para entender la estructura de la base de datos sin tener que leer todo el SQL.


## Resumen final

En resumen, este proyecto representa una base de datos completa para una empresa aeroespacial ficticia. Esta preparada para gestionar la parte de seguridad, administracion, operaciones espaciales e inventario.

La base de datos tiene 22 tablas y esta pensada para estar bien organizada, evitar datos repetidos y permitir hacer consultas utiles para el dia a dia de la empresa.
