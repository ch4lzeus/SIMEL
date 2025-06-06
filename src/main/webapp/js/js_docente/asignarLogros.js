// Datos simulados - en la realidad vienen de BD o API
const cursosAlumnos = {
  "matematica-4A": [
    "Luis Chalan",
    "Marisol Fernández",
    "Andrea Ríos"
  ],
  "historia-5B": [
    "Marisol Fernández",
    "Carlos Perez"
  ]
};

const logrosDisponibles = [
  "Participación destacada",
  "Mejor asistencia",
  "Trabajo en equipo",
  "Exposición clara",
  "Entrega puntual"
];

// Inicializar selects al cargar la página
document.addEventListener('DOMContentLoaded', () => {
  const selectTipoLogro = document.getElementById('selectTipoLogro');
  logrosDisponibles.forEach(logro => {
    const option = document.createElement('option');
    option.value = logro;
    option.textContent = logro;
    selectTipoLogro.appendChild(option);
  });
});

// Al cambiar curso, cargar alumnos y filtrar historial
document.getElementById('selectCurso').addEventListener('change', function () {
  const curso = this.value;
  const selectAlumno = document.getElementById('selectAlumno');
  selectAlumno.innerHTML = '<option selected disabled>-- Selecciona un alumno --</option>';

  if (curso && cursosAlumnos[curso]) {
    cursosAlumnos[curso].forEach(alumno => {
      const option = document.createElement('option');
      option.value = alumno;
      option.textContent = alumno;
      selectAlumno.appendChild(option);
    });
    selectAlumno.disabled = false;
  } else {
    selectAlumno.disabled = true;
  }

  filtrarHistorial(curso);
});

// Función para asignar logro, validación y agregar a tabla
function asignarLogro(event) {
  event.preventDefault();

  const cursoSelect = document.getElementById('selectCurso');
  const alumnoSelect = document.getElementById('selectAlumno');
  const tipoLogroSelect = document.getElementById('selectTipoLogro');
  const puntosInput = document.getElementById('puntos');
  const comentarioInput = document.getElementById('comentario');

  const curso = cursoSelect.value;
  const alumno = alumnoSelect.value;
  const tipoLogro = tipoLogroSelect.value;
  const puntos = parseInt(puntosInput.value);
  const comentario = comentarioInput.value.trim();

  // Validaciones
  if (!curso) {
    return Swal.fire({ icon: 'warning', title: 'Falta seleccionar curso', text: 'Por favor selecciona un curso.' });
  }
  if (!alumno) {
    return Swal.fire({ icon: 'warning', title: 'Falta seleccionar alumno', text: 'Por favor selecciona un alumno.' });
  }
  if (!tipoLogro) {
    return Swal.fire({ icon: 'warning', title: 'Falta seleccionar tipo de logro', text: 'Por favor selecciona un tipo de logro.' });
  }
  if (isNaN(puntos) || puntos < 1 || puntos > 100) {
    return Swal.fire({ icon: 'error', title: 'Puntos inválidos', text: 'Los puntos deben estar entre 1 y 100.' });
  }

  // Confirmación
  Swal.fire({
    title: '¿Deseas asignar este logro?',
    html: `<b>Curso:</b> ${cursoSelect.options[cursoSelect.selectedIndex].text}<br>
           <b>Alumno:</b> ${alumno}<br>
           <b>Logro:</b> ${tipoLogro}<br>
           <b>Puntos:</b> ${puntos}<br>
           <b>Comentario:</b> ${comentario || 'Ninguno'}`,
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'Sí, asignar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (result.isConfirmed) {
      // Agregar a tabla
      const tabla = document.querySelector("#tablaHistorial tbody");
      const fechaHoy = new Date().toISOString().split('T')[0];
      const cursoTexto = cursoSelect.options[cursoSelect.selectedIndex].text;

      const fila = `
        <tr>
          <td>${fechaHoy}</td>
          <td>${cursoTexto}</td>
          <td>${alumno}</td>
          <td>${tipoLogro}</td>
          <td>${puntos}</td>
          <td>${comentario}</td>
        </tr>`;

      tabla.insertAdjacentHTML('afterbegin', fila);

      // Reset form
      document.getElementById('formLogro').reset();
      document.getElementById('selectAlumno').disabled = true;

      Swal.fire({
        icon: 'success',
        title: 'Logro asignado',
        timer: 1500,
        showConfirmButton: false
      });

      filtrarHistorial(curso); // actualizar filtro para mostrar el nuevo registro
    }
  });

  return false;
}

// Filtrado dinámico de historial
document.getElementById('filtroHistorial').addEventListener('input', function () {
  const filtro = this.value.toLowerCase();
  filtrarHistorial(null, filtro);
});

// Función que filtra tabla historial según curso seleccionado y filtro de texto
function filtrarHistorial(cursoSeleccionado, filtroTexto) {
  const filtro = (filtroTexto || '').toLowerCase();
  const filas = document.querySelectorAll('#tablaHistorial tbody tr');

  filas.forEach(fila => {
    const textoFila = fila.innerText.toLowerCase();
    const cursoFila = fila.cells[1].innerText.toLowerCase();

    const mostrarPorCurso = cursoSeleccionado ? cursoFila === cursoSeleccionado.toLowerCase() : true;
    const mostrarPorFiltro = filtro ? textoFila.includes(filtro) : true;

    fila.style.display = (mostrarPorCurso && mostrarPorFiltro) ? '' : 'none';
  });
}
