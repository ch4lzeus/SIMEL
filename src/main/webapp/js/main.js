$(document).ready(function () {
    tablaPersonas = $("#tablaPersonas").DataTable({
        "columnDefs": [{
                "targets": -1,
                "data": null,
                "defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-primary btnEditar'>Editar</button><button class='btn btn-danger btnBorrar'>Inactivar</button></div></div>"
            }],
        "pageLength": 5, // 👈 Muestra 5 filas por defecto al cargar
        "lengthMenu": [[5, 15, 25, 50, 100], [5, 15, 25, 50, 100]], // 👈 Selector personalizado
        "language": {
            "lengthMenu": "Mostrar _MENU_ registros",
            "zeroRecords": "No se encontraron resultados",
            "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "infoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sSearch": "Buscar:",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast": "Último",
                "sNext": "Siguiente",
                "sPrevious": "Anterior"
            },
            "sProcessing": "Procesando...",
        }
    });
    $("#btnNuevo").click(function () {
        $("#formPersonas").trigger("reset");
        $("#modalCRUD .modal-header").css("background-color", "#28a745");
        $("#modalCRUD .modal-header").css("color", "white");
        $("#modalCRUD .modal-title").text("Nuevo Usuario");
        $("#modalCRUD").modal("show");
        id = null;
        opcion = 1; //alta
    });
    var fila; //capturar la fila para editar o borrar el registro

//botón EDITAR    

    $(document).on("click", ".btnEditar", function () {
        fila = $(this).closest("tr");
        id = parseInt(fila.find('td:eq(0)').text());
        nombre = fila.find('td:eq(1)').text();
        usuario = fila.find('td:eq(2)').text();
        password = fila.find('td:eq(3)').text();
        cargo = fila.find('td:eq(4)').text();
        estado = fila.find('td:eq(5)').text();
// Colocas los valores en los campos del formulario
        $("#id").val(id); // 👈 Agrega esto
        $("#nombre").val(nombre);
        $("#usuario").val(usuario);
        $("#password").val(password);
        // Cambiar el tipo del campo a "text" para mostrar la contraseña en texto plano
        $("#password").attr("type", "text");
        $("#cargo").val(cargo);
        $("#estado").val(estado);
        opcion = 2; // Editar

        $("#modalCRUD .modal-header").css("background-color", "#007bff");
        $("#modalCRUD .modal-header").css("color", "white");
        $("#modalCRUD .modal-title").text("Editar Persona");
        ;
        $("#modalCRUD").modal("show");
    });
// Inactivar usuario (eliminación lógica)
    $(document).on("click", ".btnBorrar", function () {
        fila = $(this);
        id = parseInt($(this).closest("tr").find('td:eq(0)').text());
        Swal.fire({
            title: '¿Estás seguro?',
            text: 'Esta acción inactivará al usuario.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, inactivar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "inactivarUsuario",
                    type: "POST",
                    data: {id: id},
                    success: function (respuesta) {
                        if (respuesta === "OK") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Inactivado',
                                text: 'El usuario fue inactivado correctamente.',
                                confirmButtonColor: '#d33'
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'No se pudo inactivar el usuario.',
                                confirmButtonColor: '#dc3545'
                            });
                        }
                    },
                    error: function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error de red',
                            text: 'No se pudo completar la solicitud.',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                });
            }
        });
    });
//front para registrar un nuevo usuario o editar un usuario existente
    $("#formPersonas").submit(function (e) {
        e.preventDefault();
        var id = $("#id").val(); // Necesario solo para editar
        var nombre = $("#nombre").val();
        var usuario = $("#usuario").val();
        var password = $("#password").val();
        var cargo = $("#cargo").val();
        var estado = $("#estado").val();
        if (opcion === 1) {
// Ya tienes esto funcionando, no lo toques
            $.ajax({
                url: "agregarUsuario",
                type: "POST",
                data: {
                    nombre: nombre,
                    usuario: usuario,
                    password: password,
                    cargo: cargo,
                    estado: estado
                },
                success: function (respuesta) {
                    if (respuesta === "OK") {
                        $("#modalCRUD").modal("hide");
                        Swal.fire({
                            icon: 'success',
                            title: 'Usuario agregado',
                            text: 'El usuario fue registrado correctamente.',
                            confirmButtonColor: '#3085d6'
                        }).then(() => {
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'No se pudo guardar el usuario.',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error de red',
                        text: 'No se pudo completar la solicitud.',
                        confirmButtonColor: '#dc3545'
                    });
                }
            });
        } else if (opcion === 2) {
// 👇 Esta parte es NUEVA, solo para editar
            $.ajax({
                url: "editarUsuario",
                type: "POST",
                data: {
                    id: id,
                    nombre: nombre,
                    usuario: usuario,
                    password: password,
                    cargo: cargo,
                    estado: estado
                },
                success: function (respuesta) {
                    if (respuesta === "OK") {
                        $("#modalCRUD").modal("hide");
                        Swal.fire({
                            icon: 'success',
                            title: 'Usuario actualizado',
                            text: 'Los datos del usuario fueron actualizados.',
                            confirmButtonColor: '#007bff'
                        }).then(() => {
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'No se pudo editar el usuario.',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error de red',
                        text: 'No se pudo completar la solicitud.',
                        confirmButtonColor: '#dc3545'
                    });
                }
            });
        }
    });
    // Función para generar el nombre de usuario automáticamente
    $("#nombre").on("keyup", function () {
        var nombreCompleto = $(this).val(); // Obtiene el valor del campo "Nombre"

        // Separa el nombre y el apellido
        var partesNombre = nombreCompleto.split(" ");
        // Si el nombre tiene al menos dos partes (nombre y apellido)
        if (partesNombre.length >= 2) {
            var primerNombre = partesNombre[0].toLowerCase(); // Primer nombre en minúsculas
            var primerApellido = partesNombre[1].toLowerCase(); // Primer apellido en minúsculas

            // Generar el nombre de usuario (inicial del primer nombre + apellido)
            var usuarioGenerado = primerNombre.charAt(0) + primerApellido;
            $("#usuario").val(usuarioGenerado); // Coloca el usuario generado en el campo "Usuario"
        }
    });
    $('#modalCRUD').on('hidden.bs.modal', function () {
        $("#modalCRUD .modal-header")
                .removeAttr("style") // Elimina estilos inline
                .removeClass("bg-success bg-primary bg-danger text-white text-dark"); // Elimina clases previas si las usas
        $("#modalCRUD .modal-title").text("");
    });
});
