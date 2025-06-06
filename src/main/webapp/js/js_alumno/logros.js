function mostrarDetalleLogro(nombre, curso, fecha, puntos) {
    Swal.fire({
        title: `🎖 ${nombre}`,
        html: `
            <p><strong>Curso:</strong> ${curso}</p>
            <p><strong>Fecha de obtención:</strong> ${fecha}</p>
            <p><strong>Puntos:</strong> ${puntos}</p>
        `,
        icon: 'info',
        confirmButtonText: 'Cerrar'
    });
}
