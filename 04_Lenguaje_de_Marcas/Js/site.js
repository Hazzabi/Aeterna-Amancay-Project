// Activa el menu movil y su cierre automatico en navegacion responsive.
function configurarNavegacionMovil() {
  const barraNavegacion = document.querySelector("nav");
  const botonMenu = document.querySelector(".boton-menu");

  if (!barraNavegacion || !botonMenu) {
    return;
  }

  // Cierra el menu y sincroniza el estado accesible del boton.
  const cerrarMenu = () => {
    barraNavegacion.classList.remove("abierto");
    botonMenu.setAttribute("aria-expanded", "false");
  };

  // Alterna apertura/cierre cuando se pulsa el icono del menu.
  botonMenu.addEventListener("click", () => {
    const menuAbierto = barraNavegacion.classList.toggle("abierto");
    botonMenu.setAttribute("aria-expanded", String(menuAbierto));
  });

  // Al pulsar un enlace en movil, se cierra el menu para mejorar UX.
  barraNavegacion.querySelectorAll(".enlaces-navegacion a, .acceso-navegacion").forEach((enlace) => {
    enlace.addEventListener("click", () => {
      if (window.innerWidth <= 860) {
        cerrarMenu();
      }
    });
  });

  // Si el viewport pasa a escritorio, se reinicia el estado del menu.
  window.addEventListener("resize", () => {
    if (window.innerWidth > 860) {
      cerrarMenu();
    }
  });
}

// Punto de entrada para inicializar comportamiento comun del sitio.
document.addEventListener("DOMContentLoaded", configurarNavegacionMovil);
