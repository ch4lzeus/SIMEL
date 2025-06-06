
// Datos iniciales simulados
let retosActivos = [
    {
        id: 1,
        nombre: "📘 Tareas Sin Errores",
        descripcion: "Realiza 3 tareas seguidas sin errores.",
        fechaLimite: "30/05/2025",
        puntos: 10
    },
    {
        id: 2,
        nombre: "📗 Participación Destacada",
        descripcion: "Participa en todas las clases de la semana.",
        fechaLimite: "25/05/2025",
        puntos: 15
    }
];

let retosCompletados = [
    {
        id: 3,
        nombre: "📒 Entrega Puntual",
        descripcion: "Entregaste todas las tareas a tiempo durante 2 semanas.",
        completadoEn: "10/05/2025",
        puntos: 12
    }
];

// Renderizar retos activos
function mostrarRetosActivos() {
    const container = document.querySelector("#activos .row");
    container.innerHTML = "";

    retosActivos.forEach(reto => {
        const col = document.createElement("div");
        col.className = "col";
        col.innerHTML = `
        <div class="card reto-card shadow-sm h-100">
          <div class="card-body">
            <h5 class="card-title">${reto.nombre}</h5>
            <p class="card-text">${reto.descripcion}</p>
            <p class="text-muted">Fecha límite: <strong>${reto.fechaLimite}</strong></p>
            <p class="text-success">🎯 Puntos: <strong>${reto.puntos}</strong></p>
            <button class="btn btn-primary w-100" onclick="marcarComoCompletado(${reto.id})">Marcar como completado</button>
          </div>
        </div>
      `;
        container.appendChild(col);
    });
}

// Renderizar retos completados
function mostrarRetosCompletados() {
    const container = document.querySelector("#completados .row");
    container.innerHTML = "";

    retosCompletados.forEach(reto => {
        const col = document.createElement("div");
        col.className = "col";
        col.innerHTML = `
  <div class="card reto-card shadow-sm h-100 border-secondary border-2">
    <div class="card-body position-relative">
      <span class="badge bg-success position-absolute top-0 end-0 m-2">✔ Completado</span>

      <h5 class="card-title">✅ ${reto.nombre}</h5>
      <p class="card-text">${reto.descripcion}</p>
      <p class="text-muted">Completado el: <strong>${reto.completadoEn}</strong></p>
      <p class="text-success">🎯 Puntos ganados: <strong>${reto.puntos}</strong></p>
    </div>
  </div>
      `;
        container.appendChild(col);
    });
}

// Marcar un reto como completado
function marcarComoCompletado(id) {
    const reto = retosActivos.find(r => r.id === id);

    Swal.fire({
        title: "¿Completaste este reto?",
        text: `Recibirás ${reto.puntos} puntos.`,
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Sí, completado",
        cancelButtonText: "Cancelar"
    }).then(result => {
        if (result.isConfirmed) {
            retosActivos = retosActivos.filter(r => r.id !== id);
            retosCompletados.push({
                ...reto,
                completadoEn: new Date().toLocaleDateString()
            });

            Swal.fire({
                title: "🎉 ¡Reto completado!",
                text: `"${reto.nombre}" ha sido registrado.`,
                icon: "success",
                timer: 2000,
                showConfirmButton: false
            });

            mostrarRetosActivos();
            mostrarRetosCompletados();
        }
    });
}

// Inicializar al cargar la página
document.addEventListener("DOMContentLoaded", () => {
    mostrarRetosActivos();
    mostrarRetosCompletados();
});

