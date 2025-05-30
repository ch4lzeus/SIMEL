document.getElementById('formCrearReto').addEventListener('submit', function (e) {
  e.preventDefault(); // Evita el envío real

  const nombre = document.getElementById('nombreReto').value.trim();
  const descripcion = document.getElementById('descripcionReto').value.trim();
  const fecha = document.getElementById('fechaLimite').value;
  const puntos = document.getElementById('puntosReto').value;
  const grado = document.getElementById('gradoReto').value;

  if (!nombre || !descripcion || !fecha || !puntos || !grado) {
    Swal.fire({
      icon: 'warning',
      title: 'Formulario incompleto',
      text: 'Por favor, complete todos los campos.',
    });
    return;
  }

  // Simulación de éxito
  Swal.fire({
    icon: 'success',
    title: 'Reto creado correctamente',
    text: `El reto "${nombre}" fue asignado a ${grado}.`,
  });

  // Limpiar el formulario (opcional)
  this.reset();
});
