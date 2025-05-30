// Exportar Excel (funciona bien ya)
document.querySelector('.btn-exportar-ranking').addEventListener('click', () => {
    const tabla = document.getElementById('tablaRanking');
    const wb = XLSX.utils.table_to_book(tabla, {sheet: "Ranking"});
    XLSX.writeFile(wb, "ranking_alumnos.xlsx");

    Swal.fire({
        icon: 'success',
        title: 'Exportación exitosa',
        text: 'Se ha descargado el archivo Excel.',
        timer: 1500,
        showConfirmButton: false
    });
});

// Generar PDF sin emojis
document.querySelector('.btn-generar-pdf').addEventListener('click', () => {
    const {jsPDF} = window.jspdf;
    const doc = new jsPDF();

    doc.setFontSize(16);
    doc.text('Ranking de Alumnos', doc.internal.pageSize.getWidth() / 2, 20, {align: 'center'});

    const tabla = document.getElementById('tablaRanking');
    const filas = [...tabla.querySelectorAll('tbody tr')].map(tr => {
        const tds = [...tr.children].map(td => td.innerText.trim());

        // Reemplazar la columna de medallas completa por texto limpio
        const medalla = tds[3];
        if (medalla.includes('🥇')) {
            tds[3] = 'Oro';
        } else if (medalla.includes('🥈')) {
            tds[3] = 'Plata';
        } else if (medalla.includes('🥉')) {
            tds[3] = 'Bronce';
        } else {
            tds[3] = '-';
        }

        return tds;
    });


    const columnas = ['#', 'Nombre del Alumno', 'Total de Puntos', 'Medalla'];

    doc.autoTable({
        head: [columnas],
        body: filas,
        startY: 30,
        theme: 'grid',
        styles: {halign: 'center'},
        headStyles: {fillColor: [255, 243, 205]}
    });

    doc.save('ranking_alumnos.pdf');

    Swal.fire({
        icon: 'success',
        title: 'PDF generado',
        text: 'El archivo se ha descargado correctamente.',
        timer: 1500,
        showConfirmButton: false
    });
});
