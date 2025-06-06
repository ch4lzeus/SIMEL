document.getElementById('selectCurso').addEventListener('change', function () {
  const selected = this.value; // Ejemplo valor: "1-4-A"
  const [idCurso, gradoStr, seccion] = selected.split('-');
  const grado = parseInt(gradoStr);

  fetch(`/TuContextPath/ObtenerAlumnosServlet?idCurso=${idCurso}&grado=${grado}&seccion=${seccion}`)
    .then(response => {
      if (!response.ok) throw new Error('Error en la respuesta del servidor');
      return response.json();
    })
    .then(alumnos => {
      if (!alumnos || alumnos.length === 0) {
        document.getElementById('tablaNotasBody').innerHTML = '<tr><td colspan="6">No hay alumnos para este curso</td></tr>';
        document.getElementById('tablaNotasContainer').style.display = 'block';
        return;
      }

      let html = '';
      alumnos.forEach((alumno, index) => {
        html += `
          <tr>
            <td>${alumno.nombre}</td>
            <td><input type="number" class="form-control nota-input" data-row="${index}" data-col="1" min="0" max="20" value=""></td>
            <td><input type="number" class="form-control nota-input" data-row="${index}" data-col="2" min="0" max="20" value=""></td>
            <td><input type="number" class="form-control nota-input" data-row="${index}" data-col="3" min="0" max="20" value=""></td>
            <td><input type="text" class="form-control promedio-input" id="promedio-${index}" value="--" readonly></td>
            <td><input type="text" class="form-control comentario-input" data-row="${index}" placeholder="Comentario..."></td>
          </tr>
        `;
      });

      document.getElementById('tablaNotasBody').innerHTML = html;
      document.getElementById('tablaNotasContainer').style.display = 'block';

      // Agregar listeners para validar y calcular promedio
      document.querySelectorAll('.nota-input').forEach(input => {
        input.addEventListener('input', (e) => {
          validarNotaInput(e.target);
          calcularPromedioPorFila.call(e.target);
        });
      });
    })
    .catch(error => {
      console.error('Error al cargar alumnos:', error);
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'No se pudieron cargar los alumnos. Intenta nuevamente.'
      });
    });
});

function validarNotaInput(input) {
  const val = parseFloat(input.value);
  if (isNaN(val) || val < 0 || val > 20) {
    input.classList.add('is-invalid');
    input.classList.remove('is-valid');
  } else {
    input.classList.remove('is-invalid');
    input.classList.add('is-valid');
  }
}

function calcularPromedioPorFila() {
  const row = this.dataset.row;
  const notas = document.querySelectorAll(`input.nota-input[data-row="${row}"]`);
  let suma = 0;
  let completas = 0;
  let hayError = false;

  notas.forEach(input => {
    const val = parseFloat(input.value);
    if (isNaN(val) || val < 0 || val > 20) {
      hayError = true;
    } else {
      suma += val;
      completas++;
    }
  });

  const promedioInput = document.getElementById(`promedio-${row}`);
  promedioInput.value = (!hayError && completas === 3) ? (suma / 3).toFixed(2) : '--';

  if (!hayError && completas === 3) {
    promedioInput.classList.remove('is-invalid');
    promedioInput.classList.add('is-valid');
  } else {
    promedioInput.classList.remove('is-valid');
    promedioInput.classList.add('is-invalid');
  }
}

function guardarNotas() {
  const inputsNotas = document.querySelectorAll('.nota-input');
  const inputsComentarios = document.querySelectorAll('.comentario-input');
  let erroresNotas = false;
  let erroresComentarios = false;

  inputsNotas.forEach(input => {
    const val = parseFloat(input.value);
    if (isNaN(val) || val < 0 || val > 20) {
      erroresNotas = true;
      input.classList.add('is-invalid');
    } else {
      input.classList.remove('is-invalid');
    }
  });

  inputsComentarios.forEach(input => {
    if (input.value.trim() === '') {
      erroresComentarios = true;
      input.classList.add('is-invalid');
    } else {
      input.classList.remove('is-invalid');
    }
  });

  if (erroresNotas) {
    Swal.fire({
      icon: 'error',
      title: 'Error en las notas',
      text: 'Por favor, ingresa notas válidas entre 0 y 20.'
    });
    return;
  }

  if (erroresComentarios) {
    Swal.fire({
      icon: 'error',
      title: 'Falta comentario',
      text: 'Por favor, completa todos los comentarios.'
    });
    return;
  }

  Swal.fire({
    title: '¿Deseas guardar las notas?',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'Sí, guardar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire({
        icon: 'success',
        title: 'Notas guardadas exitosamente',
        timer: 1500,
        showConfirmButton: false
      });
      // Aquí agregar lógica para guardar en BD vía fetch o formulario
    }
  });
}
