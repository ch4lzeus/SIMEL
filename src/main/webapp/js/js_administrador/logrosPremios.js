// Simulamos logros cargados (en realidad vendrían del backend)
let logros = [
    {id: 1, nombre: "Puntualidad", descripcion: "Llega a tiempo a clases"},
    {id: 2, nombre: "Participación activa", descripcion: "Interviene frecuentemente en clase"},
];

const selectLogro = document.getElementById("selectLogro");
const nombreLogro = document.getElementById("nombreLogro");
const descripcionLogro = document.getElementById("descripcionLogro");
const btnGuardar = document.getElementById("btnGuardarLogro");
const tablaBody = document.getElementById("tablaLogrosDocenteBody");

// Función para refrescar tabla de logros
function refrescarTabla() {
    tablaBody.innerHTML = "";
    logros.forEach(l => {
        tablaBody.innerHTML += `
      <tr>
        <td>${l.id}</td>
        <td>${l.nombre}</td>
        <td>${l.descripcion}</td>
<td>
  <button class="btn btn-sm btn-outline-primary btnEditar" data-id="${l.id}">
    <i class="fas fa-pen-to-square me-1"></i> Editar
  </button>
</td>

      </tr>
    `;
    });

    // Agregar evento a botones Editar
    document.querySelectorAll(".btnEditar").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.getAttribute("data-id");
            const logro = logros.find(l => l.id == id);
            if (logro) {
                // Cargar datos al formulario
                selectLogro.value = logro.id;
                nombreLogro.value = logro.nombre;
                descripcionLogro.value = logro.descripcion;
            }
        });
    });
}

// Inicializamos tabla
refrescarTabla();

// Cuando se cambia la selección en el select
selectLogro.addEventListener("change", () => {
    const id = selectLogro.value;
    if (!id) {
        // Nuevo logro, limpiar campos
        nombreLogro.value = "";
        descripcionLogro.value = "";
    } else {
        // Buscar logro y cargar datos
        const logro = logros.find(l => l.id == id);
        if (logro) {
            nombreLogro.value = logro.nombre;
            descripcionLogro.value = logro.descripcion;
        }
    }
});

// Botón guardar/editar logro
btnGuardar.addEventListener("click", () => {
    const idSeleccionado = selectLogro.value;
    const nombre = nombreLogro.value.trim();
    const descripcion = descripcionLogro.value.trim();

    // Validar que haya algo que guardar o editar
    if (!idSeleccionado && !nombre) {
        Swal.fire({
            icon: 'warning',
            title: 'Error',
            text: 'Por favor seleccione un logro existente o escriba un nombre para un nuevo logro.',
            confirmButtonText: 'OK'
        });
        return;
    }

    if (nombre === "") {
        Swal.fire({
            icon: 'warning',
            title: 'Error',
            text: 'El nombre del logro no puede estar vacío.',
            confirmButtonText: 'OK'
        });
        return;
    }

    if (idSeleccionado) {
        // Editar logro existente
        const index = logros.findIndex(l => l.id == idSeleccionado);
        if (index > -1) {
            logros[index].nombre = nombre;
            logros[index].descripcion = descripcion;
            Swal.fire({
                icon: 'success',
                title: '¡Listo!',
                text: 'Logro actualizado con éxito.',
                confirmButtonText: 'OK'
            });
        }
    } else {
        // Crear nuevo logro (simulación de ID autoincremental)
        const nuevoId = logros.length ? logros[logros.length - 1].id + 1 : 1;
        logros.push({id: nuevoId, nombre, descripcion});
        Swal.fire({
            icon: 'success',
            title: '¡Listo!',
            text: 'Logro creado y asignado con éxito.',
            confirmButtonText: 'OK'
        });
        // Agregar al select
        const option = document.createElement("option");
        option.value = nuevoId;
        option.textContent = nombre;
        selectLogro.appendChild(option);
        selectLogro.value = nuevoId;
    }

    refrescarTabla();

    // Limpiar campos para nuevo ingreso
    nombreLogro.value = "";
    descripcionLogro.value = "";
    selectLogro.value = "";
});
