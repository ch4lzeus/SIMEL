document.addEventListener("DOMContentLoaded", function () {
    // Docente
    const formDocente = document.getElementById("form-asignar-docente");
    const cursosAsignados = document.getElementById("cursos-asignados-docente");

    // Alumno
    const formAlumno = document.getElementById("form-asignar-alumno");
    const historialList = document.getElementById("historial-academico");

    // 👉 Asignación de cursos a docentes
    formDocente.addEventListener("submit", function (e) {
        e.preventDefault();
        const formData = new FormData(formDocente);
        const idDocente = formData.get("id_docente");
        const cursos = formData.getAll("cursos");

        if (!idDocente) {
            Swal.fire({
                icon: 'warning',
                title: 'Ups...',
                text: 'Por favor selecciona un docente.'
            });
            return;
        }

        if (cursos.length === 0) {
            Swal.fire({
                icon: 'info',
                title: 'Sin cursos seleccionados',
                text: 'Selecciona al menos un curso para asignar.'
            });
            return;
        }

        let nuevosCursos = [];
        cursos.forEach(cursoId => {
            const label = formDocente.querySelector(`input[value="${cursoId}"]`).nextElementSibling.textContent.trim();
            const yaExiste = Array.from(cursosAsignados.children).some(li => li.textContent.includes(label));
            if (!yaExiste) {
                nuevosCursos.push(label);
            }
        });

        if (nuevosCursos.length === 0) {
            Swal.fire({
                icon: 'info',
                title: 'Sin cambios',
                text: 'No hay cursos nuevos para asignar.'
            });
            return;
        }

        nuevosCursos.forEach(nombre => {
            const li = document.createElement("li");
            li.className = "list-group-item d-flex justify-content-between align-items-center";
            li.textContent = nombre;
            const badge = document.createElement("span");
            badge.className = "badge badge-success";
            badge.textContent = "Activo";
            li.appendChild(badge);
            cursosAsignados.appendChild(li);
        });

        Swal.fire({
            icon: 'success',
            title: 'Asignado',
            text: 'Cursos asignados correctamente.'
        });
    });

    // 👉 Actualizar cursos de alumnos
    formAlumno.addEventListener("submit", function (e) {
        e.preventDefault();
        const formData = new FormData(formAlumno);
        const idAlumno = formData.get("id_alumno");
        const cursosManual = formData.getAll("cursos_manual");

        if (!idAlumno) {
            Swal.fire({
                icon: 'warning',
                title: 'Ups...',
                text: 'Por favor selecciona un alumno.'
            });
            return;
        }

        if (cursosManual.length === 0) {
            Swal.fire({
                icon: 'info',
                title: 'Sin selección',
                text: 'Selecciona al menos un curso para actualizar.'
            });
            return;
        }

        cursosManual.forEach(cursoId => {
            const label = formAlumno.querySelector(`input[value="${cursoId}"]`).nextElementSibling.textContent.trim();
            const yaExiste = Array.from(historialList.children).some(li => li.textContent.includes(label));
            if (!yaExiste) {
                const li = document.createElement("li");
                li.className = "list-group-item";
                li.textContent = `2024 - ${label} - Asignado manualmente`;
                historialList.appendChild(li);
            }
        });

        Swal.fire({
            icon: 'success',
            title: 'Actualizado',
            text: 'Cursos del alumno actualizados correctamente.'
        });
    });
        
});
