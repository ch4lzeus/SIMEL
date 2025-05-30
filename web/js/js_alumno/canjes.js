const puntosUsuario = 15; // ← reemplazar con dato real del usuario
let canjes = []; // Para almacenar los canjes realizados

function generarCodigo() {
  const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let codigo = '';
  for (let i = 0; i < 8; i++) {
    codigo += caracteres.charAt(Math.floor(Math.random() * caracteres.length));
  }
  return codigo;
}

function canjearPremio(nombrePremio, puntosNecesarios, tipoPremio) {
  if (puntosUsuario >= puntosNecesarios) {
    Swal.fire({
      title: `¿Deseas canjear "${nombrePremio}"?`,
      html: `Este premio cuesta <strong>${puntosNecesarios} puntos</strong>.<br>Tipo de premio: <strong>${tipoPremio.toUpperCase()}</strong>`,
      icon: 'question',
      showCancelButton: true,
      confirmButtonText: 'Sí, canjear',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        const codigo = generarCodigo(); // Generar el código único
        const estadoCanje = tipoPremio === 'digital' ? 'Canje digital exitoso' : 'Canje físico solicitado';

        // Agregar el canje a la lista de canjes
        canjes.push({
          nombre: nombrePremio,
          codigo: codigo,
          estado: estadoCanje,
          tipo: tipoPremio,
        });

        // Mostrar el código en la alerta
        Swal.fire({
          title: estadoCanje,
          html: `Has canjeado <strong>${nombrePremio}</strong>.<br><strong>Código de canje: ${codigo}</strong>.<br><br>
            Guarda este código para canjearlo más tarde.`,
          icon: 'success',
          showConfirmButton: true
        });

        // Actualizar la lista de canjes realizados en la interfaz
        actualizarCanjesRealizados();
      }
    });
  } else {
    Swal.fire({
      title: 'Puntos insuficientes',
      text: `Necesitas ${puntosNecesarios} puntos. Solo tienes ${puntosUsuario}.`,
      icon: 'error',
      confirmButtonText: 'OK'
    });
  }
}

// Función para actualizar la lista de canjes realizados
function actualizarCanjesRealizados() {
  const listaCanjes = document.getElementById('canjesRealizados');
  listaCanjes.innerHTML = ''; // Limpiar la lista antes de actualizarla

  canjes.forEach((canje) => {
    const item = document.createElement('div');
    item.classList.add('list-group-item', 'list-group-item-action');
    item.innerHTML = `
      <strong>${canje.nombre}</strong><br>
      Código de canje: <code>${canje.codigo}</code><br>
      Estado: ${canje.estado}<br>
      Tipo: ${canje.tipo === 'digital' ? 'Premio digital' : 'Premio físico'}
    `;
    listaCanjes.appendChild(item);
  });
}

// Filtro por puntos disponibles
document.getElementById('filtroPuntos').addEventListener('change', function () {
  const filtro = this.value;
  const tarjetas = document.querySelectorAll('#catalogoPremios .col');

  tarjetas.forEach((tarjeta) => {
    const textoPuntos = tarjeta.querySelector('.puntos-requeridos').innerText;
    const puntosNecesarios = parseInt(textoPuntos.match(/\d+/)[0]);

    if (filtro === 'disponibles' && puntosUsuario < puntosNecesarios) {
      tarjeta.style.display = 'none';
    } else {
      tarjeta.style.display = 'block';
    }
  });
});
