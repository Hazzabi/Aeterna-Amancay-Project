# Aeterna Amancay - Documentación del Proyecto

Esta página web representa la infraestructura digital de **Aeterna Amancay**. Consta de una **parte pública** para presentar la empresa y sus misiones, y una **parte privada** (Portal de Cliente) donde los usuarios institucionales pueden visualizar la telemetría de sus satélites y el estado de sus contratos en tiempo real.

**Enlace a la web:** [https://aeterna-amancay.netlify.app/](https://aeterna-amancay.netlify.app/)

## Organización de Archivos

### Páginas HTML (Estructura)
* **index.html:** Página de inicio. Presenta la identidad de la marca, servicios principales, cifras clave y acceso rápido a contacto.
* **misiones.html:** Registro histórico de lanzamientos. Los datos no están escritos en el HTML; se generan dinámicamente desde el XML.
* **contacto.html:** Centro de atención al cliente y formulario de consultas comerciales o técnicas.
* **login.html:** Portal de acceso seguro. Contiene el formulario de validación de credenciales.
* **dashboard.html:** Panel privado del cliente. Carga datos personalizados según el perfil del usuario que inicia sesión.
* **panel.html:** Archivo de redirección técnica hacia el dashboard para asegurar la compatibilidad de enlaces.

### Lógica y Estilo (Conectividad)
* **css/styles.css:** Hoja de estilos centralizada. Controla el diseño estelar, la tipografía, los componentes de interfaz (tarjetas, botones) y la adaptabilidad móvil (responsive).
* **Js/site.js:** Gestión de la interfaz común. Controla principalmente el despliegue y cierre del menú de navegación en dispositivos móviles.
* **datos/vision.xml:** Actúa como la base de datos central del proyecto. Está validado por un esquema (**vision.xsd**) y organiza la información en tres grandes bloques:
    1.  **usuarios:** Contiene las credenciales (`acceso` y `clave`) e información de cuenta.
    2.  **misiones:** Listado de operaciones orbitales pasadas y presentes.
    3.  **paneles:** Datos técnicos y financieros vinculados a cada cliente (satélites, contratos y actividad reciente).

## Funcionamiento de los Scripts (Lógica en Español)

* **Js/login.js:** * Lee la sección `<usuarios>` del XML.
    * Comprueba si el valor de los campos `<acceso>` y `<clave>` coincide con lo introducido en el formulario.
    * Si es correcto, crea una sesión en `sessionStorage` bajo la clave `aeterna_cliente` guardando el `id` del usuario y redirige a `dashboard.html`.
* **Js/dashboard.js:** * Verifica la existencia de la sesión. Si no existe, devuelve al usuario al login.
    * Recupera del XML el `<panel>` cuyo atributo `id_usuario` coincida con el ID de la sesión activa.
    * Renderiza automáticamente la información de los nodos `<satelite>`, `<contrato>` y `<evento>`.
* **Js/misiones.js:** * Extrae los datos de la sección `<misiones>` del XML.
    * Calcula el resumen estadístico superior y genera la línea de tiempo visual de forma dinámica.

## Credenciales de Acceso (Pruebas)

| Acceso | Clave (Sello) | Cliente |
| :--- | :--- | :--- |
| **mciencia** | hash_cli_01 | Ministerio de Ciencia de España |
| **geoscan** | hash_cli_02 | GeoScan Analytics SL |
| **northsky** | hash_cli_03 | NorthSky Dynamics |
| **oagrolabs** | hash_cli_04 | Orbital Agro Labs |
