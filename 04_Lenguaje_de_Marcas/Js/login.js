const RUTA_XML_ACCESO = "datos/vision.xml";
const CLAVE_SESION_CLIENTE = "aeterna_cliente";

// Convierte texto XML en un documento utilizable por el navegador.
function analizarXml(textoXml) {
  const analizador = new DOMParser();
  const documentoXml = analizador.parseFromString(textoXml, "text/xml");

  if (documentoXml.getElementsByTagName("parsererror").length > 0) {
    throw new Error("No se ha podido verificar el acceso en este momento.");
  }

  return documentoXml;
}

// Obtiene el texto de una etiqueta hija concreta.
function obtenerTextoEtiqueta(nodoPadre, nombreEtiqueta) {
  const nodo = nodoPadre.getElementsByTagName(nombreEtiqueta)[0];
  return nodo && nodo.textContent ? nodo.textContent.trim() : "";
}

// Pinta mensajes de estado del formulario de acceso.
function mostrarEstado(tipo, mensaje) {
  const cajaEstado = document.getElementById("mensaje-estado");
  cajaEstado.className = "caja-estado " + tipo + " visible";
  cajaEstado.textContent = mensaje;
}

// Limpia cualquier estado previo antes de empezar.
function limpiarEstado() {
  const cajaEstado = document.getElementById("mensaje-estado");
  cajaEstado.className = "";
  cajaEstado.textContent = "";
}

// Carga y parsea el archivo XML que centraliza usuarios y paneles.
async function cargarDocumentoVision() {
  const respuesta = await fetch(RUTA_XML_ACCESO);

  if (!respuesta.ok) {
    throw new Error("El portal de acceso no esta disponible temporalmente.");
  }

  return analizarXml(await respuesta.text());
}

// Gestiona el inicio de sesion validando acceso y clave contra el XML.
async function gestionarInicioSesion(evento) {
  evento.preventDefault();

  const botonAcceder = document.getElementById("boton-acceder");
  const usuario = document.getElementById("campo-usuario").value.trim();
  const clave = document.getElementById("campo-sello").value.trim();

  if (!usuario || !clave) {
    mostrarEstado("error", "Debes completar el identificador de alma y el sello de acceso.");
    return;
  }

  botonAcceder.disabled = true;
  mostrarEstado("cargando", "Comprobando tus datos...");

  try {
    const documentoXml = await cargarDocumentoVision();
    const seccionUsuarios = documentoXml.getElementsByTagName("usuarios")[0];
    const listaUsuarios = seccionUsuarios ? Array.from(seccionUsuarios.getElementsByTagName("usuario")) : [];

    const usuarioCoincidente = listaUsuarios.find((nodoUsuario) => {
      return obtenerTextoEtiqueta(nodoUsuario, "acceso") === usuario
        && obtenerTextoEtiqueta(nodoUsuario, "clave") === clave;
    });

    if (!usuarioCoincidente) {
      mostrarEstado("error", "Los datos no son correctos.");
      return;
    }

    const estadoCuenta = obtenerTextoEtiqueta(usuarioCoincidente, "estado").toLowerCase();

    if (estadoCuenta === "bloqueada") {
      mostrarEstado("error", "La cuenta esta bloqueada. Contacta con Guardianes IT.");
      return;
    }

    const datosSesion = {
      id: usuarioCoincidente.getAttribute("id"),
      nombre: obtenerTextoEtiqueta(usuarioCoincidente, "nombre"),
      usuario,
      rol: obtenerTextoEtiqueta(usuarioCoincidente, "tipo")
    };

    sessionStorage.setItem(CLAVE_SESION_CLIENTE, JSON.stringify(datosSesion));
    mostrarEstado("exito", "Acceso concedido. Abriendo tu panel privado...");

    window.setTimeout(() => {
      window.location.href = "dashboard.html";
    }, 700);
  } catch (error) {
    mostrarEstado("error", error.message);
  } finally {
    botonAcceder.disabled = false;
  }
}

// Al cargar la pagina se comprueba sesion previa y se activa el formulario.
document.addEventListener("DOMContentLoaded", () => {
  const sesionActual = sessionStorage.getItem(CLAVE_SESION_CLIENTE);

  if (sesionActual) {
    window.location.href = "dashboard.html";
    return;
  }

  limpiarEstado();
  document.getElementById("formulario-acceso").addEventListener("submit", gestionarInicioSesion);
});
