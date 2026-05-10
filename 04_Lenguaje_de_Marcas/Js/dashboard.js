const RUTA_XML_PANEL = "datos/vision.xml";
const CLAVE_SESION_PANEL = "aeterna_cliente";

// Convierte texto XML en un documento valido para su lectura.
function analizarXml(textoXml) {
  const analizador = new DOMParser();
  const documentoXml = analizador.parseFromString(textoXml, "text/xml");

  if (documentoXml.getElementsByTagName("parsererror").length > 0) {
    throw new Error("No se ha podido preparar el panel privado.");
  }

  return documentoXml;
}

// Obtiene el texto limpio de una etiqueta hija.
function obtenerTextoEtiqueta(nodoPadre, nombreEtiqueta) {
  const nodo = nodoPadre.getElementsByTagName(nombreEtiqueta)[0];
  return nodo && nodo.textContent ? nodo.textContent.trim() : "";
}

// Evita inyecciones HTML al renderizar datos dinamicos.
function escaparHtml(valor) {
  return String(valor)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/\"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

// Decide la variante visual de la insignia segun el estado.
function obtenerClaseInsignia(estado) {
  const estadoNormalizado = String(estado).toLowerCase();

  if (estadoNormalizado.includes("activo") || estadoNormalizado.includes("orbita") || estadoNormalizado.includes("cobrado")) {
    return "exito";
  }

  if (estadoNormalizado.includes("pendiente") || estadoNormalizado.includes("construccion")) {
    return "informacion";
  }

  if (estadoNormalizado.includes("pausa") || estadoNormalizado.includes("alerta")) {
    return "aviso";
  }

  return "peligro";
}

// Formatea importes en euros para tablas economicas.
function formatearMoneda(valor) {
  const numero = Number(valor);

  if (Number.isNaN(numero)) {
    return valor;
  }

  return new Intl.NumberFormat("es-ES", {
    style: "currency",
    currency: "EUR",
    maximumFractionDigits: 0
  }).format(numero);
}

// Convierte fechas ISO a formato humano en espanol.
function formatearFechaHora(valor) {
  const fecha = new Date(valor);

  if (Number.isNaN(fecha.getTime())) {
    return valor;
  }

  return new Intl.DateTimeFormat("es-ES", {
    day: "2-digit",
    month: "short",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit"
  }).format(fecha);
}

// Recupera y parsea los datos de sesion del cliente logueado.
function obtenerClienteEnSesion() {
  const sesionSerializada = sessionStorage.getItem(CLAVE_SESION_PANEL);

  if (!sesionSerializada) {
    return null;
  }

  try {
    return JSON.parse(sesionSerializada);
  } catch {
    return null;
  }
}

// Redirecciona al login cuando no hay sesion valida.
function redirigirALogin() {
  window.location.href = "login.html";
}

// Busca el panel que corresponde al cliente autenticado.
function buscarPanelCliente(documentoXml, idUsuario) {
  const seccionPaneles = documentoXml.getElementsByTagName("paneles")[0];

  if (!seccionPaneles) {
    return null;
  }

  return Array.from(seccionPaneles.getElementsByTagName("panel")).find((nodoPanel) => {
    return nodoPanel.getAttribute("id_usuario") === idUsuario;
  }) || null;
}

// Muestra indicadores de alto nivel en la cabecera del panel.
function pintarIndicadores(listaSatelites, listaContratos, listaEventos) {
  const totalSatelites = listaSatelites.length;

  const energiaMedia = totalSatelites
    ? Math.round(listaSatelites.reduce((acumulado, satelite) => acumulado + Number(satelite.energia || 0), 0) / totalSatelites)
    : 0;

  const totalContratosActivos = listaContratos.filter((contrato) => {
    const estado = String(contrato.estado).toLowerCase();
    return !estado.includes("pausa") && !estado.includes("anulado") && !estado.includes("cancelado");
  }).length;

  document.getElementById("indicadores-panel").innerHTML = `
    <article class="tarjeta-metrica">
      <span class="valor-metrica">${totalSatelites}</span>
      <span class="etiqueta-metrica">Satelites visibles</span>
    </article>
    <article class="tarjeta-metrica">
      <span class="valor-metrica">${energiaMedia}%</span>
      <span class="etiqueta-metrica">Energia media</span>
    </article>
    <article class="tarjeta-metrica">
      <span class="valor-metrica">${totalContratosActivos}</span>
      <span class="etiqueta-metrica">Contratos activos</span>
    </article>
    <article class="tarjeta-metrica">
      <span class="valor-metrica">${listaEventos.length}</span>
      <span class="etiqueta-metrica">Eventos recientes</span>
    </article>
  `;
}

// Renderiza tarjetas de telemetria del cliente.
function pintarTelemetria(listaSatelites) {
  const panelTelemetria = document.getElementById("panel-telemetria");

  if (!listaSatelites.length) {
    panelTelemetria.innerHTML = '<div class="estado-vacio">No hay satelites asignados a esta cuenta.</div>';
    return;
  }

  panelTelemetria.innerHTML = listaSatelites.map((satelite, indice) => `
    <article class="tarjeta-telemetria">
      <header>
        <div>
          <h3>${escaparHtml(satelite.nombre)}</h3>
          <span class="atenuado">SAT-${String(indice + 1).padStart(2, "0")}</span>
        </div>
        <span class="insignia ${obtenerClaseInsignia(satelite.estado)}">${escaparHtml(satelite.estado)}</span>
      </header>
      <div class="cuadricula-telemetria">
        <div>
          <span class="valor">${escaparHtml(satelite.energia)}%</span>
          <span class="etiqueta">Energia</span>
        </div>
        <div>
          <span class="valor">${escaparHtml(satelite.altitud)} km</span>
          <span class="etiqueta">Altitud</span>
        </div>
        <div>
          <span class="valor">${escaparHtml(satelite.estado)}</span>
          <span class="etiqueta">Estado</span>
        </div>
      </div>
    </article>
  `).join("");
}

// Dibuja la tabla de contratos del cliente.
function pintarContratos(listaContratos) {
  const panelContratos = document.getElementById("panel-contratos");

  if (!listaContratos.length) {
    panelContratos.innerHTML = '<div class="estado-vacio">No hay contratos visibles para esta cuenta.</div>';
    return;
  }

  const filas = listaContratos.map((contrato, indice) => `
    <tr>
      <td>CTR-${String(indice + 1).padStart(2, "0")}</td>
      <td>
        <strong>${escaparHtml(contrato.nombre)}</strong><br>
        <span class="atenuado">${escaparHtml(contrato.estado)}</span>
      </td>
      <td>${formatearMoneda(contrato.importe)}</td>
      <td><span class="insignia ${obtenerClaseInsignia(contrato.estado)}">${escaparHtml(contrato.estado)}</span></td>
    </tr>
  `).join("");

  panelContratos.innerHTML = `
    <table>
      <thead>
        <tr>
          <th>Contrato</th>
          <th>Servicio</th>
          <th>Importe</th>
          <th>Estado</th>
        </tr>
      </thead>
      <tbody>${filas}</tbody>
    </table>
  `;
}

// Muestra feed de actividad reciente para el cliente.
function pintarActividad(listaEventos) {
  const panelActividad = document.getElementById("panel-actividad");

  if (!listaEventos.length) {
    panelActividad.innerHTML = '<div class="estado-vacio">Sin actividad reciente registrada para este cliente.</div>';
    return;
  }

  panelActividad.innerHTML = listaEventos.map((evento) => `
    <article class="elemento-actividad">
      <time datetime="${escaparHtml(evento.fecha)}">${escaparHtml(formatearFechaHora(evento.fecha))}</time>
      <p>${escaparHtml(evento.texto)}</p>
      <p class="atenuado">Centro de mision</p>
    </article>
  `).join("");
}

// Aplica el mismo mensaje de error en los tres paneles principales.
function mostrarErrorGeneral(mensaje) {
  const contenidoError = `<div class="estado-vacio">${escaparHtml(mensaje)}</div>`;
  document.getElementById("panel-telemetria").innerHTML = contenidoError;
  document.getElementById("panel-contratos").innerHTML = contenidoError;
  document.getElementById("panel-actividad").innerHTML = contenidoError;
}

// Carga XML, localiza el panel del cliente y renderiza todos los bloques.
async function cargarPanelPrivado() {
  const clienteSesion = obtenerClienteEnSesion();

  if (!clienteSesion) {
    redirigirALogin();
    return;
  }

  document.getElementById("cliente-bienvenida").textContent = "Bienvenida, " + clienteSesion.nombre;
  document.getElementById("cliente-detalle").textContent =
    "Estas viendo tu resumen privado como cliente " + clienteSesion.rol + ".";

  const respuesta = await fetch(RUTA_XML_PANEL);

  if (!respuesta.ok) {
    throw new Error("El panel privado no esta disponible temporalmente.");
  }

  const documentoXml = analizarXml(await respuesta.text());
  const nodoPanelCliente = buscarPanelCliente(documentoXml, clienteSesion.id);

  if (!nodoPanelCliente) {
    throw new Error("No hay panel asignado para la sesion actual.");
  }

  const listaSatelites = Array.from(nodoPanelCliente.getElementsByTagName("satelite")).map((nodoSatelite) => ({
    nombre: obtenerTextoEtiqueta(nodoSatelite, "nombre"),
    energia: obtenerTextoEtiqueta(nodoSatelite, "energia"),
    altitud: obtenerTextoEtiqueta(nodoSatelite, "altitud"),
    estado: obtenerTextoEtiqueta(nodoSatelite, "estado")
  }));

  const listaContratos = Array.from(nodoPanelCliente.getElementsByTagName("contrato")).map((nodoContrato) => ({
    nombre: obtenerTextoEtiqueta(nodoContrato, "nombre"),
    importe: obtenerTextoEtiqueta(nodoContrato, "importe"),
    estado: obtenerTextoEtiqueta(nodoContrato, "estado")
  }));

  const listaEventos = Array.from(nodoPanelCliente.getElementsByTagName("evento")).map((nodoEvento) => ({
    fecha: obtenerTextoEtiqueta(nodoEvento, "fecha"),
    texto: obtenerTextoEtiqueta(nodoEvento, "texto")
  }));

  pintarIndicadores(listaSatelites, listaContratos, listaEventos);
  pintarTelemetria(listaSatelites);
  pintarContratos(listaContratos);
  pintarActividad(listaEventos);
}

// Registra eventos iniciales del panel al terminar de cargar el DOM.
document.addEventListener("DOMContentLoaded", () => {
  document.getElementById("boton-cerrar-sesion").addEventListener("click", () => {
    sessionStorage.removeItem(CLAVE_SESION_PANEL);
    redirigirALogin();
  });

  cargarPanelPrivado().catch((error) => {
    mostrarErrorGeneral(error.message);
  });
});
