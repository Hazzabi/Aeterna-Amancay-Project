const RUTA_XML_MISIONES = "datos/vision.xml";

// Convierte texto XML en un documento para consulta.
function analizarXml(textoXml) {
  const analizador = new DOMParser();
  const documentoXml = analizador.parseFromString(textoXml, "text/xml");

  if (documentoXml.getElementsByTagName("parsererror").length > 0) {
    throw new Error("No se ha podido abrir el registro de misiones.");
  }

  return documentoXml;
}

// Obtiene el texto de una etiqueta hija y define un valor por defecto.
function obtenerTextoEtiqueta(nodoPadre, nombreEtiqueta) {
  const nodo = nodoPadre.getElementsByTagName(nombreEtiqueta)[0];
  return nodo && nodo.textContent ? nodo.textContent.trim() : "--";
}

// Evita inyecciones HTML en contenido mostrado en pantalla.
function escaparHtml(valor) {
  return String(valor)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/\"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

// Convierte la fecha ISO a formato legible en espanol.
function formatearFecha(fechaIso) {
  const fecha = new Date(fechaIso);

  if (Number.isNaN(fecha.getTime())) {
    return fechaIso;
  }

  return new Intl.DateTimeFormat("es-ES", {
    day: "2-digit",
    month: "long",
    year: "numeric"
  }).format(fecha);
}

// Define el color de la insignia segun el estado de la mision.
function obtenerVarianteInsignia(estado) {
  const estadoNormalizado = String(estado).toLowerCase();

  if (estadoNormalizado.includes("exito")) {
    return "exito";
  }

  if (estadoNormalizado.includes("parcial") || estadoNormalizado.includes("curso")) {
    return "informacion";
  }

  if (estadoNormalizado.includes("pendiente")) {
    return "aviso";
  }

  return "peligro";
}

// Construye la tarjeta visual de cada mision para la linea temporal.
function crearTarjetaMision(mision) {
  const identificador = escaparHtml(mision.id);
  const nombreMision = escaparHtml(mision.nombre);
  const nombreCliente = escaparHtml(mision.cliente);
  const estadoMision = escaparHtml(mision.estado);
  const detalleMision = escaparHtml(mision.detalle);

  return `
    <article class="elemento-linea-tiempo">
      <div class="tarjeta-linea-tiempo">
        <span class="fecha-linea-tiempo">${escaparHtml(formatearFecha(mision.fecha))}</span>
        <h3 class="titulo-mision">${nombreMision}</h3>
        <div class="fila-insignias">
          <span class="insignia ${obtenerVarianteInsignia(mision.estado)}">${estadoMision}</span>
          <span class="insignia informacion">${identificador}</span>
        </div>
        <p class="texto-tarjeta">${detalleMision}</p>
        <dl class="cuadricula-detalle">
          <div>
            <dt>Cliente</dt>
            <dd>${nombreCliente}</dd>
          </div>
          <div>
            <dt>Estado</dt>
            <dd>${estadoMision}</dd>
          </div>
        </dl>
      </div>
    </article>
  `;
}

// Calcula y muestra un resumen rapido con estadisticas de misiones.
function actualizarResumenMisiones(listaMisiones) {
  const resumen = document.getElementById("resumen-misiones");

  if (!listaMisiones.length) {
    return;
  }

  const misionesPorFecha = [...listaMisiones].sort((a, b) => new Date(b.fecha) - new Date(a.fecha));

  const contadorEstados = listaMisiones.reduce((acumulado, mision) => {
    acumulado[mision.estado] = (acumulado[mision.estado] || 0) + 1;
    return acumulado;
  }, {});

  const estadoPredominante = Object.entries(contadorEstados).sort((a, b) => b[1] - a[1])[0][0];

  resumen.innerHTML = `
    <article class="tarjeta-resumen">
      <strong>${listaMisiones.length}</strong>
      <span>Total de misiones</span>
    </article>
    <article class="tarjeta-resumen">
      <strong>${escaparHtml(misionesPorFecha[0].cliente)}</strong>
      <span>Ultimo cliente registrado</span>
    </article>
    <article class="tarjeta-resumen">
      <strong>${escaparHtml(estadoPredominante)}</strong>
      <span>Estado predominante</span>
    </article>
  `;
}

// Carga las misiones desde XML y renderiza timeline + estado general.
async function cargarMisiones() {
  const cajaEstado = document.getElementById("estado-carga");
  const contenedorMisiones = document.getElementById("contenedor-misiones");

  try {
    const respuesta = await fetch(RUTA_XML_MISIONES);

    if (!respuesta.ok) {
      throw new Error("El archivo de misiones no esta disponible en este momento.");
    }

    const documentoXml = analizarXml(await respuesta.text());
    const nodosMision = Array.from(documentoXml.getElementsByTagName("mision"));

    const listaMisiones = nodosMision.map((nodoMision) => ({
      id: nodoMision.getAttribute("id") || "M-00",
      nombre: obtenerTextoEtiqueta(nodoMision, "nombre"),
      fecha: obtenerTextoEtiqueta(nodoMision, "fecha"),
      cliente: obtenerTextoEtiqueta(nodoMision, "cliente"),
      estado: obtenerTextoEtiqueta(nodoMision, "estado"),
      detalle: obtenerTextoEtiqueta(nodoMision, "detalle")
    }));

    actualizarResumenMisiones(listaMisiones);
    contenedorMisiones.innerHTML = listaMisiones.map(crearTarjetaMision).join("");

    cajaEstado.className = "caja-estado exito";
    cajaEstado.textContent = "Misiones cargadas correctamente.";
  } catch (error) {
    cajaEstado.className = "caja-estado error";
    cajaEstado.textContent = error.message;
    contenedorMisiones.innerHTML = `
      <div class="estado-vacio">
        No se pudieron mostrar las misiones. Intentalo de nuevo dentro de unos minutos.
      </div>
    `;
  }
}

// Inicia la carga al terminar de construir el DOM.
document.addEventListener("DOMContentLoaded", cargarMisiones);
