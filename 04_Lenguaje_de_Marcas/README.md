# Aeterna Amancay

Esta pagina web tiene una parte publica para presentar la empresa y sus misiones, y una parte privada donde un cliente puede entrar con usuario y clave para ver su panel.

## Como esta organizado

- `index.html`: es la pagina principal. Muestra la portada, servicios, cifras y contacto rapido.
- `misiones.html`: muestra el registro de misiones. No escribe las misiones a mano en el HTML, las carga desde `datos/vision.xml` usando `Js/misiones.js`.
- `contacto.html`: contiene los datos de contacto y un formulario visual.
- `login.html`: contiene el formulario de acceso de clientes.
- `dashboard.html`: es el panel privado del cliente. Solo debe verse bien despues de iniciar sesion.
- `panel.html`: es una ruta que redirige a `dashboard.html`, para no romper enlaces anteriores.

## Como se conectan los archivos

El archivo `css/styles.css` da el estilo a todas las paginas. Ahi estan las clases comunes como la navegacion, tarjetas, botones, formularios, panel privado y version responsive para movil.

El archivo `Js/site.js` se carga en casi todas las paginas. Su trabajo es activar el menu movil: cuando se pulsa el boton del menu, abre o cierra los enlaces de navegacion.

El archivo `datos/vision.xml` funciona como una base de datos sencilla. Guarda tres cosas importantes:

- `usuarios`: los usuarios y claves que se comprueban en el login.
- `misiones`: los datos que se pintan en la pagina de misiones.
- `paneles`: la informacion privada de cada cliente, como satelites, contratos y actividad.

`Js/login.js` lee el XML, busca si el usuario y la clave existen, y si son correctos guarda una sesion en `sessionStorage` con la clave `aeterna_cliente`. Despues manda al cliente a `dashboard.html`.

`Js/dashboard.js` comprueba si existe esa sesion. Si no existe, manda al usuario a `login.html`. Si existe, vuelve a leer el XML, busca el panel que tenga el mismo `id_usuario` que el cliente logueado, y pinta los indicadores, satelites, contratos y actividad.

`Js/misiones.js` tambien lee el XML, pero usa la parte de `misiones`. Con esos datos crea las tarjetas de la linea de tiempo y el resumen superior.

## Credenciales para probar el login

| Usuario | Clave | Cliente |
| --- | --- | --- |
| `mciencia` | `hash_cli_01` | Ministerio de Ciencia de Espana |
| `geoscan` | `hash_cli_02` | GeoScan Analytics SL |
| `northsky` | `hash_cli_03` | NorthSky Dynamics |
| `oagrolabs` | `hash_cli_04` | Orbital Agro Labs |

Estas claves son solo de prueba. Como estan en un XML dentro del proyecto, no son seguras para una web real.

Para probar el acceso privado, entra en `login.html`, usa una de las credenciales de arriba y despues revisa el panel del cliente.
