document.addEventListener('DOMContentLoaded', () => {
  const formCrearReto = document.getElementById('formCrearReto');
  const tablaRetosBody = document.getElementById('tablaRetosBody');
  const btnCancelarEdicion = document.getElementById('btnCancelarEdicionReto');

  const nombreInput = document.getElementById('nombreReto');
  const descripcionInput = document.getElementById('descripcionReto');
  const fechaInput = document.getElementById('fechaLimite');
  const puntosInput = document.getElementById('puntosReto');
  const gradoInput = document.getElementById('gradoReto');

  let retos = [];
  let idContador = 1;
  let idEditando = null;

  formCrearReto.addEventListener('submit', function (e) {
    e.preventDefault();

    const nombre = nombreInput.value.trim();
    const descripcion = descripcionInput.value.trim();
    const fecha = fechaInput.value;
    const puntos = puntosInput.value.trim();
    const grado = gradoInput.value;

    if (!nombre || !descripcion || !fecha || !puntos || !grado) {
      Swal.fire({
        icon: 'warning',
        title: 'Formulario incompleto',
        text: 'Por favor, complete todos los campos.',
      });
      return;
    }

    if (idEditando !== null) {
      // Editar reto existente
      const reto = retos.find(r => r.id === idEditando);
      reto.nombre = nombre;
      reto.descripcion = descripcion;
      reto.fechaLimite = fecha;
      reto.puntos = parseInt(puntos);
      reto.grado = grado;

      Swal.fire({
        icon: 'success',
        title: 'Reto actualizado correctamente',
        text: `El reto "${nombre}" fue modificado.`,
      });

      idEditando = null;
      btnCancelarEdicion.style.display = "none";
    } else {
      // Crear nuevo reto
      retos.push({
        id: idContador++,
        nombre,
        descripcion,
        fechaLimite: fecha,
        puntos: parseInt(puntos),
        grado
      });

      Swal.fire({
        icon: 'success',
        title: 'Reto creado correctamente',
        text: `El reto "${nombre}" fue asignado a ${grado}.`,
      });
    }

    this.reset();
    renderizarTabla();
  });

  btnCancelarEdicion.addEventListener('click', () => {
    idEditando = null;
    formCrearReto.reset();
    btnCancelarEdicion.style.display = "none";
  });

  function renderizarTabla() {
    tablaRetosBody.innerHTML = "";

    retos.forEach(reto => {
      tablaRetosBody.innerHTML += `
        <tr>
          <td>${reto.id}</td>
          <td>${reto.nombre}</td>
          <td>${reto.descripcion}</td>
          <td>${reto.fechaLimite}</td>
          <td>${reto.puntos}</td>
          <td>${reto.grado}</td>
          <td>
            <button class="btn btn-sm btn-warning me-2 btn-editar" data-id="${reto.id}">
              <i class="fas fa-edit"></i>
            </button>
            <button class="btn btn-sm btn-danger btn-eliminar" data-id="${reto.id}">
              <i class="fas fa-trash-alt"></i>
            </button>
          </td>
        </tr>
      `;
    });

    document.querySelectorAll(".btn-editar").forEach(btn => {
      btn.addEventListener("click", () => {
        const id = parseInt(btn.getAttribute("data-id"));
        const reto = retos.find(r => r.id === id);
        if (reto) {
          nombreInput.value = reto.nombre;
          descripcionInput.value = reto.descripcion;
          fechaInput.value = reto.fechaLimite;
          puntosInput.value = reto.puntos;
          gradoInput.value = reto.grado;
          idEditando = reto.id;
          btnCancelarEdicion.style.display = "inline-block";
        }
      });
    });

    document.querySelectorAll(".btn-eliminar").forEach(btn => {
      btn.addEventListener("click", () => {
        const id = parseInt(btn.getAttribute("data-id"));
        Swal.fire({
          title: '¿Estás seguro?',
          text: "Esta acción no se puede deshacer.",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'Sí, eliminar',
          cancelButtonText: 'Cancelar'
        }).then((result) => {
          if (result.isConfirmed) {
            retos = retos.filter(r => r.id !== id);
            renderizarTabla();
            Swal.fire('Eliminado', 'El reto ha sido eliminado.', 'success');
          }
        });
      });
    });
  }
});
