document.addEventListener("DOMContentLoaded", () => {
    // Elementos base del DOM
    const selectReporte = document.getElementById("tipo-reporte");
    const contenedorTablaReporte = document.getElementById("contenedor-tabla-reporte");
    const tituloImpresion = document.querySelector("#seccion-reportes h2");

    // Botones
    const btnGenerar = document.getElementById("btn-generar-reporte");
    const btnExportarPDF = document.getElementById("btn-exportar-pdf");
    const btnExportarExcel = document.getElementById("btn-exportar-excel");
    const btnImprimir = document.getElementById("btn-imprimir");

    // Eventos
    btnGenerar.addEventListener("click", generarReporte);
    btnExportarPDF.addEventListener("click", exportarPDF);
    btnExportarExcel.addEventListener("click", exportarExcel);
    btnImprimir.addEventListener("click", imprimirReporte);

    // Función: Generar contenido según el tipo de reporte
    function generarReporte() {
        const tipo = selectReporte.value;
        let contenidoHTML = "";
        let tituloReporte = "";

        switch (tipo) {
            case "cursos":
                contenidoHTML = `
                    <table class="table table-bordered">
                        <thead>
                            <tr><th>Curso</th><th>Promedio</th></tr>
                        </thead>
                        <tbody>
                            <tr><td>Matemática</td><td>16.5</td></tr>
                            <tr><td>Historia</td><td>15.2</td></tr>
                            <tr><td>Comunicación</td><td>17.1</td></tr>
                        </tbody>
                    </table>`;
                tituloReporte = "📘 Cursos - Promedios Generales";
                break;

            case "alumnos":
                contenidoHTML = `
                    <table class="table table-bordered">
                        <thead><tr><th>Alumno</th><th>Puntos</th><th>Ranking</th></tr></thead>
                        <tbody>
                            <tr><td>Juan Pérez</td><td>120</td><td>🥇</td></tr>
                            <tr><td>María Gómez</td><td>110</td><td>🥈</td></tr>
                            <tr><td>Pedro Sánchez</td><td>105</td><td>🥉</td></tr>
                        </tbody>
                    </table>`;
                tituloReporte = "🎓 Alumnos - Ranking por Puntos";
                break;

            case "docentes":
                contenidoHTML = `
                    <table class="table table-bordered">
                        <thead><tr><th>Docente</th><th>Último acceso</th><th>Cursos asignados</th></tr></thead>
                        <tbody>
                            <tr><td>Prof. López</td><td>2025-05-10</td><td>3</td></tr>
                            <tr><td>Prof. García</td><td>2025-05-12</td><td>2</td></tr>
                        </tbody>
                    </table>`;
                tituloReporte = "👩‍🏫 Docentes - Uso del Sistema";
                break;

            case "canjes":
                contenidoHTML = `
                    <table class="table table-bordered">
                        <thead><tr><th>Alumno</th><th>Premio</th><th>Estado</th><th>Fecha</th></tr></thead>
                        <tbody>
                            <tr><td>Juan Pérez</td><td>Chocolate</td><td>Pendiente</td><td>2025-05-14</td></tr>
                            <tr><td>María Gómez</td><td>Cuaderno</td><td>Entregado</td><td>2025-05-13</td></tr>
                        </tbody>
                    </table>`;
                tituloReporte = "🎁 Canjes Realizados";
                break;

            default:
                contenidoHTML = "<p>Seleccione un tipo de reporte válido.</p>";
        }

        contenedorTablaReporte.innerHTML = contenidoHTML;
        tituloImpresion.innerHTML = "📈 Reportes - " + tituloReporte;

        Swal.fire({
            icon: 'success',
            title: '¡Reporte generado!',
            text: 'Puedes exportarlo o imprimirlo si lo deseas.',
            timer: 2000,
            showConfirmButton: false
        });
    }

    // Función: Exportar a PDF usando jsPDF + autoTable
    function exportarPDF() {
        const doc = new jspdf.jsPDF();
        const tituloOriginal = tituloImpresion.textContent;
        const tituloLimpio = tituloOriginal.replace(/[^\x00-\x7F]/g, ""); // eliminar emojis

        const tabla = document.querySelector(".tabla-reporte table");
        const encabezados = [];
        const filas = [];

        tabla.querySelectorAll("thead th").forEach(th => encabezados.push(th.textContent));
        tabla.querySelectorAll("tbody tr").forEach(tr => {
            const fila = [];
            tr.querySelectorAll("td").forEach(td => fila.push(td.textContent));
            filas.push(fila);
        });

        doc.text(tituloLimpio, 10, 10);
        doc.autoTable({
            head: [encabezados],
            body: filas,
            startY: 20,
            theme: 'grid'
        });

        doc.save("reporte.pdf");
    }

    // Función: Exportar a Excel con SheetJS
    function exportarExcel() {
        const ws = XLSX.utils.table_to_sheet(document.querySelector(".tabla-reporte table"));
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Reporte");
        XLSX.writeFile(wb, "reporte.xlsx");
    }

    // Función: Imprimir la tabla generada
    function imprimirReporte() {
        const contenidoImprimir = `
            <div style="text-align: center; font-size: 24px; font-weight: bold; color: #4e73df;">
                Reportes
            </div>
            <div style="text-align: center; font-size: 20px; margin: 20px 0;">
                ${tituloImpresion.innerHTML}
            </div>
            ${contenedorTablaReporte.innerHTML}
        `;

        const ventanaImpresion = window.open('', '', 'width=800,height=600');
        ventanaImpresion.document.write(`
            <html>
                <head><title>Imprimir Reporte</title></head>
                <body>
                    ${contenidoImprimir}
                    <script type="text/javascript">
                        window.print();
                        window.onafterprint = function() { window.close(); };
                    </script>
                </body>
            </html>
        `);
        ventanaImpresion.document.close();
    }
});
