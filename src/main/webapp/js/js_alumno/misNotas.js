document.getElementById('selectCursoNota').addEventListener('change', function () {
    const cursoSeleccionado = this.value;

    const datosCurso = {
        matematica: {
            evaluaciones: ['Diagnóstico', 'Parcial', 'Final'],
            notas: [14.5, 12.0, 16.5],
            comentarios: ['Buen comienzo', 'Mejorar en geometría', 'Excelente progreso']
        },
        historia: {
            evaluaciones: ['Diagnóstico', 'Parcial', 'Final'],
            notas: [13.0, 14.5, 15.0],
            comentarios: ['Regular participación', 'Buen avance', 'Trabajo consistente']
        },
        ciencia: {
            evaluaciones: ['Diagnóstico', 'Parcial', 'Final'],
            notas: [15.0, 13.5, 14.5],
            comentarios: ['Buen inicio', 'Atención a detalle', 'Participación activa']
        }
    };

    const data = datosCurso[cursoSeleccionado];
    const tbody = document.getElementById('tablaNotas');
    tbody.innerHTML = '';

    data.evaluaciones.forEach((eval, index) => {
        const row = `
            <tr>
                <td>${eval}</td>
                <td>${data.notas[index]}</td>
                <td>${data.comentarios[index]}</td>
            </tr>
        `;
        tbody.innerHTML += row;
    });

    const promedio = (data.notas.reduce((a, b) => a + b, 0) / data.notas.length).toFixed(2);
    document.getElementById('promedio').innerText = promedio;

    // 👇 Primero mostramos el contenido (asegura que canvas sea visible)
    document.getElementById('contenidoNotas').style.display = 'block';

    // 👇 Luego esperamos brevemente y dibujamos el gráfico
    setTimeout(() => {
        mostrarGrafico(data.evaluaciones, data.notas);
    }, 50); // El delay ayuda a asegurar que el canvas esté visible
});

// Función para mostrar gráfico
let chartInstance = null;
function mostrarGrafico(labels, data) {
    const ctx = document.getElementById('graficoNotas').getContext('2d');

    // Destruir gráfico anterior si existe
    if (chartInstance) {
        chartInstance.destroy();
    }

    chartInstance = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Notas', // Puedes dejarlo así, aunque no se mostrará
                data: data,
                borderColor: '#0d6efd',
                backgroundColor: '#0d6efd',
                fill: false,
                tension: 0.2,
                pointRadius: 5,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false // ✅ Oculta la leyenda
                },
                title: {
                    display: true,
                    text: 'Evolución de notas en el curso',
                    font: {
                        size: 16
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 20,
                    title: {
                        display: true,
                        text: 'Nota'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Evaluaciones'
                    }
                }
            }
        }
    });
}

