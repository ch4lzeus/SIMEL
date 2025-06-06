document.addEventListener('DOMContentLoaded', () => {

    let premios = [];
    let modoEdicion = false;

    const premioId = document.getElementById("premioId");
    const nombrePremio = document.getElementById("nombrePremio");
    const descripcionPremio = document.getElementById("descripcionPremio");
    const puntosPremio = document.getElementById("puntosPremio");
    const tipoPremio = document.getElementById("tipoPremio");
    const archivoImagenPremio = document.getElementById("archivoImagenPremio");
    const previewImagenPremio = document.getElementById("previewImagenPremio");
    const btnGuardar = document.getElementById("btnGuardarPremio");
    const btnCancelar = document.getElementById("btnCancelarEdicion");
    const tablaPremiosBody = document.getElementById("tablaPremiosBody");

// Vista previa de imagen
    archivoImagenPremio.addEventListener("change", function () {
        const file = archivoImagenPremio.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = e => {
                previewImagenPremio.innerHTML = `<img src="${e.target.result}" class="img-thumbnail" width="120">`;
            };
            reader.readAsDataURL(file);
        }
    });

// Guardar premio
    btnGuardar.addEventListener("click", () => {
        const nombre = nombrePremio.value.trim();
        const descripcion = descripcionPremio.value.trim();
        const puntos = parseInt(puntosPremio.value, 10);
        const tipo = tipoPremio.value;
        const imagen = previewImagenPremio.querySelector("img")?.src || "";

        if (!nombre || !descripcion || isNaN(puntos) || !tipo || !imagen) {
            alert("Completa todos los campos.");
            return;
        }

        if (modoEdicion) {
            const id = parseInt(premioId.value, 10);
            const premio = premios.find(p => p.id === id);
            if (premio) {
                premio.nombre = nombre;
                premio.descripcion = descripcion;
                premio.puntos = puntos;
                premio.tipo = tipo;
                premio.imagen = imagen;
            }
            modoEdicion = false;
            btnCancelar.style.display = "none";
        } else {
            const nuevoPremio = {
                id: premios.length + 1,
                nombre,
                descripcion,
                puntos,
                tipo,
                imagen
            };
            premios.push(nuevoPremio);
        }

        limpiarFormulario();
        renderizarTabla();
    });

    btnCancelar.addEventListener("click", () => {
        limpiarFormulario();
        modoEdicion = false;
        btnCancelar.style.display = "none";
    });

// Renderizar premios en tabla
    function renderizarTabla() {
        tablaPremiosBody.innerHTML = "";
        premios.forEach(p => {
            tablaPremiosBody.innerHTML += `
      <tr>
        <td>${p.id}</td>
        <td>${p.nombre}</td>
        <td>${p.descripcion}</td>
        <td>${p.puntos}</td>
        <td>${p.tipo}</td>
        <td><img src="${p.imagen}" class="img-thumbnail" width="80"></td>
        <td>
          <button class="btn btn-sm btn-warning me-2" onclick="editarPremio(${p.id})">
            <i class="fas fa-edit"></i>
          </button>
          <button class="btn btn-sm btn-danger" onclick="eliminarPremio(${p.id})">
            <i class="fas fa-trash-alt"></i>
          </button>
        </td>
      </tr>
    `;
        });
    }

// Editar premio
    window.editarPremio = function (id) {
        const premio = premios.find(p => p.id === id);
        if (premio) {
            premioId.value = premio.id;
            nombrePremio.value = premio.nombre;
            descripcionPremio.value = premio.descripcion;
            puntosPremio.value = premio.puntos;
            tipoPremio.value = premio.tipo;
            previewImagenPremio.innerHTML = `<img src="${premio.imagen}" class="img-thumbnail" width="120">`;
            modoEdicion = true;
            btnCancelar.style.display = "inline-block";
        }
    };

// Eliminar premio
    window.eliminarPremio = function (id) {
        if (confirm("¿Deseas eliminar este premio?")) {
            premios = premios.filter(p => p.id !== id);
            renderizarTabla();
        }
    };

    function limpiarFormulario() {
        premioId.value = "";
        nombrePremio.value = "";
        descripcionPremio.value = "";
        puntosPremio.value = "";
        tipoPremio.value = "";
        archivoImagenPremio.value = "";
        previewImagenPremio.innerHTML = "";
    }


// Aquí va TODO tu código JS, desde la obtención de elementos hasta las funciones.

    document.getElementById('archivoImagenPremio').addEventListener('change', function () {
        const label = document.querySelector('label[for="archivoImagenPremio"]');
        const fileName = this.files[0]?.name || "Elegir imagen";
        label.innerHTML = `<i class="fas fa-upload me-2"></i> ${fileName}`;
    });


});