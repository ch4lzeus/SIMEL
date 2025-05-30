function verDetalleCurso(nombreCurso) {
    Swal.fire({
        title: `📘 Detalles del curso: ${nombreCurso}`,
        html: `
        <p><strong>Contenido:</strong> Este curso incluye evaluaciones, tareas y actividades.</p>
        <p><strong>Horario:</strong> Lunes y miércoles - 10:00 a.m.</p>
        <p><strong>Duración:</strong> Marzo a Junio</p>
      `,
        icon: 'info',
        confirmButtonText: 'Cerrar'
    });
}

