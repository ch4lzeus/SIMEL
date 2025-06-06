$('#formLogin').submit(function (e) {
    e.preventDefault();
    var usuario = $.trim($("#usuario").val());
    var password = $.trim($("#password").val());

    if (usuario.length == "" || password == "") {
        Swal.fire({
            type: 'warning',
            title: 'Debe ingresar un usuario y/o password',
        });
        return false;
    } else {
        $.ajax({
            url: "LoginServlet", // La URL del servlet
            type: "POST",
            dataType: "json", // Esperamos un JSON como respuesta
            data: {usuario: usuario, password: password},
            success: function (data) {
                if (data.status === "error") {
                    Swal.fire({
                        type: 'error',
                        title: data.message, // Mostramos el mensaje de error
                    });
                } else if (data.status === "inactive") {
                    // Si el usuario está inactivo
                    Swal.fire({
                        type: 'error', // Usamos 'error' porque es un estado de error
                        title: 'Usuario Inactivo', // Título para usuario inactivo
                        text: 'Por favor contacte al administrador.',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Cerrar',
                    });
                } else if (data.status === "success") {
                    Swal.fire({
                        type: 'success',
                        title: 'Bienvenido',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Ingresar'
                    }).then((result) => {
                        if (result.value) {
                            // Mostrar el loader cuando el usuario hace clic en "Ingresar"
                            $('#loader').show(); // Mostrar el loader

                            // Aquí se podría poner un pequeño retraso (2 o 3 segundos) para que la animación del loader sea visible
                            setTimeout(() => {
                                // Redirigir al panel correspondiente después de unos segundos
                                window.location.href = data.redirectPage;
                            }, 1000); // 1 segundos (puedes ajustar este tiempo)
                        }
                    });
                }

            },
            error: function (xhr, status, error) {
                Swal.fire({
                    type: 'error',
                    title: 'Hubo un problema con la solicitud',
                });
            }
        });
    }
});
