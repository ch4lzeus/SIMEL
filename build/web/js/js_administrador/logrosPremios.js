document.addEventListener("DOMContentLoaded", function () {
  const tablaBody = document.getElementById("tabla-logros-body");
  const btnCrear = document.getElementById("btn-crear-logro");
  const btnCriterios = document.getElementById("btn-criterios-logros");

  btnCrear.addEventListener("click", crearLogro);
  btnCriterios.addEventListener("click", establecerCriterios);

  // Función para crear un nuevo logro
  function crearLogro() {
    Swal.fire({
      title: 'Crear nuevo logro',
      html: obtenerFormularioLogro(),
      confirmButtonText: 'Guardar',
      focusConfirm: false,
      preConfirm: () => obtenerDatosFormulario('crear'),
    }).then(result => {
      if (result.isConfirmed && result.value) {
        const logro = result.value;
        agregarLogroATabla(logro);
        agregarLogroAMedallas(logro);
        Swal.fire("¡Logro creado!", "", "success");
      }
    });
  }

  // Función para editar un logro existente
  tablaBody.addEventListener("click", function (e) {
    if (e.target.closest(".btn-editar-logro")) {
      const btn = e.target.closest("button");
      const fila = btn.closest("tr");
      const logro = obtenerDatosFila(fila);

      Swal.fire({
        title: 'Editar logro',
        html: obtenerFormularioLogro(logro),
        confirmButtonText: 'Actualizar',
        focusConfirm: false,
        preConfirm: () => obtenerDatosFormulario('editar'),
      }).then(result => {
        if (result.isConfirmed && result.value) {
          actualizarFilaDesdeLogro(fila, result.value);
          Swal.fire("¡Logro actualizado!", "", "success");
        }
      });
    }
  });

  // Función para mostrar criterios (placeholder)
  function establecerCriterios() {
    Swal.fire({
      title: "Criterios automáticos",
      html: `
        <p><strong>Ejemplo:</strong> "Si promedio > 15, asignar <em>Logro Académico</em>"</p>
        <p>Esta funcionalidad estará disponible cuando se integre con el sistema académico.</p>
      `,
      icon: "info"
    });
  }

  // 👉 Genera el formulario (crear/editar)
  function obtenerFormularioLogro(datos = {}) {
    return `
      <label>🏅 Icono:
        <select id="logro-icono" class="form-select">
          ${["🏅", "🎯", "📚", "💡", "🧠"].map(icono =>
            `<option ${datos.icono === icono ? "selected" : ""}>${icono}</option>`
          ).join("")}
        </select>
      </label><br><br>
      <label>🏷 Nombre:
        <input type="text" id="logro-nombre" class="form-control" value="${datos.nombre || ""}" placeholder="Ej: Logro Académico">
      </label><br>
      <label>📝 Descripción:
        <input type="text" id="logro-desc" class="form-control" value="${datos.descripcion || ""}" placeholder="Ej: Promedio superior a 15">
      </label><br>
      <label>⭐ Puntos:
        <input type="number" id="logro-puntos" class="form-control" value="${datos.puntos || 10}">
      </label><br>
      <label>📅 Periodo:
        <select id="logro-periodo" class="form-select">
          ${["2025-I", "2025-II", "2026-I"].map(p =>
            `<option ${datos.periodo === p ? "selected" : ""}>${p}</option>`
          ).join("")}
        </select>
      </label><br>
      <label>✅ Activo:
        <input type="checkbox" id="logro-activo" ${datos.activo !== false ? "checked" : ""}>
      </label>
    `;
  }

  // 👉 Obtiene datos del formulario SweetAlert
  function obtenerDatosFormulario(tipo) {
    const icono = document.getElementById("logro-icono").value;
    const nombre = document.getElementById("logro-nombre").value.trim();
    const descripcion = document.getElementById("logro-desc").value.trim();
    const puntos = parseInt(document.getElementById("logro-puntos").value, 10);
    const periodo = document.getElementById("logro-periodo").value;
    const activo = document.getElementById("logro-activo").checked;

    if (!nombre || !descripcion || isNaN(puntos)) {
      Swal.showValidationMessage("Todos los campos son obligatorios");
      return false;
    }

    return { icono, nombre, descripcion, puntos, periodo, activo };
  }

  // 👉 Agrega logro a la tabla
  function agregarLogroATabla(logro) {
    const filaHTML = `
      <tr>
        <td>${logro.icono}</td>
        <td>${logro.nombre}</td>
        <td>${logro.descripcion}</td>
        <td><span class="badge bg-primary">+${logro.puntos} pts</span></td>
        <td>${logro.periodo}</td>
        <td>
          <input type="checkbox" class="toggle-estado-logro" ${logro.activo ? "checked" : ""}>
        </td>
        <td>
          <button class="btn btn-outline-primary btn-sm btn-editar-logro">
            <i class="fas fa-edit"></i> Editar
          </button>
        </td>
      </tr>
    `;
    tablaBody.insertAdjacentHTML("beforeend", filaHTML);
  }

  // 👉 Obtiene datos desde una fila de la tabla
  function obtenerDatosFila(fila) {
    const celdas = fila.querySelectorAll("td");
    return {
      icono: celdas[0].textContent,
      nombre: celdas[1].textContent,
      descripcion: celdas[2].textContent,
      puntos: parseInt(celdas[3].textContent),
      periodo: celdas[4].textContent,
      activo: celdas[5].querySelector("input").checked
    };
  }

  // 👉 Actualiza la fila en la tabla
  function actualizarFilaDesdeLogro(fila, logro) {
    const celdas = fila.querySelectorAll("td");
    celdas[0].textContent = logro.icono;
    celdas[1].textContent = logro.nombre;
    celdas[2].textContent = logro.descripcion;
    celdas[3].innerHTML = `<span class="badge bg-primary">+${logro.puntos} pts</span>`;
    celdas[4].textContent = logro.periodo;
    celdas[5].querySelector("input").checked = logro.activo;
  }

  // 👉 Agrega vista previa en sección de medallas
  function agregarLogroAMedallas(logro) {
    const contenedor = document.getElementById("medallas-preview");
    const div = document.createElement("div");
    div.className = "medalla";
    div.title = logro.descripcion;
    div.textContent = `${logro.icono} ${logro.nombre}`;
    contenedor.appendChild(div);
  }
});
