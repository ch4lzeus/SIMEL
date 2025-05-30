// Función para mostrar SweetAlert y agregar un nuevo premio a la tabla
function agregarPremio() {
  Swal.fire({
    title: 'Agregar nuevo premio',
    html: `
      <label>🎁 Nombre del premio:
        <input type="text" id="premio-nombre" class="form-control" placeholder="Ej: Mochila escolar">
      </label><br>
      <label>📝 Descripción:
        <input type="text" id="premio-desc" class="form-control" placeholder="Ej: Mochila resistente y moderna">
      </label><br>
      <label>⭐ Puntos requeridos:
        <input type="number" id="premio-puntos" class="form-control" value="20">
      </label><br>
      <label>📦 Stock disponible:
        <input type="number" id="premio-stock" class="form-control" value="10">
      </label>
    `,
    confirmButtonText: 'Guardar',
    preConfirm: () => {
      const nombre = document.getElementById("premio-nombre").value.trim();
      const desc = document.getElementById("premio-desc").value.trim();
      const puntos = document.getElementById("premio-puntos").value.trim();
      const stock = document.getElementById("premio-stock").value.trim();

      if (!nombre || !desc || !puntos || !stock) {
        Swal.showValidationMessage("Todos los campos son obligatorios");
        return false;
      }

      const icono = obtenerIcono(nombre);

      agregarFilaATabla({ icono, nombre, desc, puntos, stock });

      Swal.fire("¡Premio agregado!", "", "success");
    }
  });
}

// Función para editar premio en una fila específica
function editarPremio(btn) {
  const fila = btn.closest("tr");
  const celdas = fila.querySelectorAll("td");

  const nombreCompleto = celdas[0].textContent.trim();
  const icono = nombreCompleto.charAt(0);
  const nombre = nombreCompleto.slice(2); // Remueve emoji y espacio
  const desc = celdas[1].textContent;
  const puntos = celdas[2].textContent;
  const stock = celdas[3].textContent;

  Swal.fire({
    title: 'Editar premio',
    html: `
      <label>🎁 Nombre:
        <input type="text" id="edit-nombre" class="form-control" value="${nombre}">
      </label><br>
      <label>📝 Descripción:
        <input type="text" id="edit-desc" class="form-control" value="${desc}">
      </label><br>
      <label>⭐ Puntos requeridos:
        <input type="number" id="edit-puntos" class="form-control" value="${puntos}">
      </label><br>
      <label>📦 Stock:
        <input type="number" id="edit-stock" class="form-control" value="${stock}">
      </label>
    `,
    confirmButtonText: 'Actualizar',
    preConfirm: () => {
      const nuevoNombre = document.getElementById("edit-nombre").value.trim();
      const nuevaDesc = document.getElementById("edit-desc").value.trim();
      const nuevosPuntos = document.getElementById("edit-puntos").value.trim();
      const nuevoStock = parseInt(document.getElementById("edit-stock").value.trim());

      celdas[0].textContent = `${icono} ${nuevoNombre}`;
      celdas[1].textContent = nuevaDesc;
      celdas[2].textContent = nuevosPuntos;
      celdas[3].textContent = nuevoStock;

      const selectEntrega = celdas[4].querySelector("select");
      selectEntrega.disabled = nuevoStock === 0;

      Swal.fire("¡Premio actualizado!", "", "success");
    }
  });
}

// Función para mostrar historial ficticio (estático por ahora)
function verHistorial() {
  Swal.fire({
    title: "📜 Historial de Canjes",
    html: `
      <ul style="text-align: left;">
        <li>Juan Pérez canjeó 🎁 Mochila - 05/05/2025</li>
        <li>María Gómez canjeó 🍫 Chocolate - 02/05/2025</li>
        <li>Juan Pérez canjeó 📚 Cuaderno - 30/04/2025</li>
      </ul>
    `,
    icon: "info"
  });
}

// Función auxiliar para determinar ícono por nombre del premio
function obtenerIcono(nombre) {
  nombre = nombre.toLowerCase();
  if (nombre.includes("chocolate")) return "🍫";
  if (nombre.includes("cuaderno")) return "📚";
  if (nombre.includes("mochila")) return "🎒";
  return "🎁";
}

// Función auxiliar para agregar una fila a la tabla
function agregarFilaATabla({ icono, nombre, desc, puntos, stock }) {
  const fila = `
    <tr>
      <td>${icono} ${nombre}</td>
      <td>${desc}</td>
      <td>${puntos}</td>
      <td>${stock}</td>
      <td>
        <select class="form-select form-select-sm" ${stock == 0 ? "disabled" : ""}>
          <option>Pendiente</option>
          <option>Entregado</option>
        </select>
      </td>
      <td>
        <button class="btn btn-primary btn-sm" onclick="editarPremio(this)">✏️ Editar</button>
      </td>
    </tr>
  `;
  document.getElementById("tabla-canjes-body").insertAdjacentHTML("beforeend", fila);
}
