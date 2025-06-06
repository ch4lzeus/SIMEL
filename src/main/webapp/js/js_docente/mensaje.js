// Datos simulados
const gradosDocente = ['4to', '6to'];

const retosPendientesPorAlumno = {
  '4to': [
    {
      alumnoId: 1,
      nombreAlumno: 'Jose Campos',
      retos: [
        {
          id: 1,
          nombre: '📘 Tareas Sin Errores',
          descripcion: 'Realiza 3 tareas seguidas sin errores.',
          fechaLimite: '30/05/2025',
          puntos: 10,
          estado: 'Pendiente'
        },
        {
          id: 2,
          nombre: '📗 Participación Destacada',
          descripcion: 'Participa en todas las clases de la semana.',
          fechaLimite: '25/05/2025',
          puntos: 15,
          estado: 'Pendiente'
        }
      ]
    }
  ],
  '6to': [
    {
      alumnoId: 2,
      nombreAlumno: 'Neymar Urteaga',
      retos: [
        {
          id: 3,
          nombre: '📒 Entrega Puntual',
          descripcion: 'Entregaste todas las tareas a tiempo durante 2 semanas.',
          fechaLimite: '20/06/2025',
          puntos: 12,
          estado: 'Pendiente'
        }
      ]
    }
  ]
};

function cargarGrados() {
  const selectGrado = document.getElementById('selectGrado');
  gradosDocente.forEach(grado => {
    const option = document.createElement('option');
    option.value = grado;
    option.textContent = grado;
    selectGrado.appendChild(option);
  });
}

function mostrarRetosDelGrado(grado) {
  const contenedor = document.getElementById('contenedorRetos');
  contenedor.innerHTML = '';
  contenedor.style.display = 'block';

  const alumnos = retosPendientesPorAlumno[grado] || [];

  if (alumnos.length === 0) {
    contenedor.innerHTML = `<p>No hay retos pendientes para el grado ${grado}.</p>`;
    return;
  }

  alumnos.forEach(alumno => {
    const divAlumno = document.createElement('div');
    divAlumno.className = 'alumno';

    let retosHTML = '';
    alumno.retos.forEach(reto => {
      retosHTML += `
        <div class="reto-card" id="reto-${alumno.alumnoId}-${reto.id}">
          <h5>${reto.nombre}</h5>
          <p>${reto.descripcion}</p>
          <p><strong>Fecha límite:</strong> ${reto.fechaLimite}</p>
          <p><strong>Puntos:</strong> ${reto.puntos}</p>
          <select class="select-estado" 
            onchange="cambiarEstado(this, ${alumno.alumnoId}, ${reto.id}, '${grado}')">
            <option value="Pendiente" ${reto.estado === 'Pendiente' ? 'selected' : ''}>Pendiente</option>
            <option value="Completado" ${reto.estado === 'Completado' ? 'selected' : ''}>Completado</option>
            <option value="Rechazado" ${reto.estado === 'Rechazado' ? 'selected' : ''}>Rechazado</option>
          </select>
        </div>
      `;
    });

    divAlumno.innerHTML = `
      <h4>👦 Alumno: ${alumno.nombreAlumno}</h4>
      ${retosHTML}
    `;

    contenedor.appendChild(divAlumno);
  });
}

function cambiarEstado(selectElement, alumnoId, retoId, grado) {
  const nuevoEstado = selectElement.value;
  const alumno = retosPendientesPorAlumno[grado].find(a => a.alumnoId === alumnoId);
  const reto = alumno.retos.find(r => r.id === retoId);
  reto.estado = nuevoEstado;

  Swal.fire({
    icon: 'success',
    title: 'Estado actualizado',
    text: `El reto fue marcado como "${nuevoEstado}".`,
    timer: 2000,
    showConfirmButton: false
  });
}

document.addEventListener('DOMContentLoaded', () => {
  cargarGrados();

  document.getElementById('btnMostrarRetos').addEventListener('click', () => {
    const gradoSeleccionado = document.getElementById('selectGrado').value;
    mostrarRetosDelGrado(gradoSeleccionado);
  });
});
