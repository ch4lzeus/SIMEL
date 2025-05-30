document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.btn-ver-alumnos').forEach(button => {
    button.addEventListener('click', () => {
      const curso = button.getAttribute('data-curso');
      const grado = button.getAttribute('data-grado');
      const seccion = button.getAttribute('data-seccion');

      // Simulamos los alumnos
      const alumnos = [
        { nombre: 'Juan Pérez', id: 1 },
        { nombre: 'María López', id: 2 },
        { nombre: 'Carlos Ramírez', id: 3 }
      ];

      let htmlAlumnos = '<ul class="list-group text-left">';
      alumnos.forEach(a => {
        htmlAlumnos += `<li class="list-group-item">${a.nombre}</li>`;
      });
      htmlAlumnos += '</ul>';

      Swal.fire({
        title: `👨‍🏫 Alumnos de ${curso} (${grado} ${seccion})`,
        html: htmlAlumnos,
        icon: 'info',
        confirmButtonText: 'Cerrar',
        customClass: {
          popup: 'text-left'
        }
      });
    });
  });
});
