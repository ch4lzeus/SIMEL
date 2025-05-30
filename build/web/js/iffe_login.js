(function () {

    const formLogin = document.querySelector(".form-login");
    const inputPass = document.querySelector('.form-login input[type="password"]');
    const inputUser = document.querySelector('.form-login input[type="user"]');
    const alertaError = document.querySelector(".form-login .alerta-error");
    const alertaExito = document.querySelector(".form-login .alerta-exito");

    const userRegex = /^.{4,12}$/;
    const passwordRegex = /^.{4,12}$/;

    const estadoValidacionCampos = {
        userName: false,
        userPassword: false,
    };

    document.addEventListener("DOMContentLoaded", () => {
        formLogin.addEventListener("submit", (e) => {
            e.preventDefault();
            enviarFormulario();
        });

        inputUser.addEventListener("input", () => {
            validarCampo(userRegex, inputUser, "El usuario debe tener entre 6 a 12 caracteres.");
        });

        inputPass.addEventListener("input", () => {
            validarCampo(passwordRegex, inputPass, " La clave debe tener entre 4 a 12 caracteres ");
        });
    });

    function validarCampo(regularExpresion, campo, mensaje) {
        const validarCampo = regularExpresion.test(campo.value);
        if (validarCampo) {
            eliminarAlerta(campo.parentElement.parentElement);
            estadoValidacionCampos[campo.name] = true;
            campo.parentElement.classList.remove("error");
            return;
        }
        estadoValidacionCampos[campo.name] = false;
        campo.parentElement.classList.add("error");
        mostrarAlerta(campo.parentElement.parentElement, mensaje);
    }

    function mostrarAlerta(referencia, mensaje) {
        eliminarAlerta(referencia);
        const alertaDiv = document.createElement("div");
        alertaDiv.classList.add("alerta");
        alertaDiv.textContent = mensaje;
        referencia.appendChild(alertaDiv);
    }

    function eliminarAlerta(referencia) {
        const alerta = referencia.querySelector(".alerta");

        if (alerta)
            alerta.remove();
    }

    function enviarFormulario() {

        //VALIDAMOS EL ENVIO DE NUESTRO FORMULARIO

        if (estadoValidacionCampos.userName && estadoValidacionCampos.userPassword) {

            estadoValidacionCampos.userName = false;
            estadoValidacionCampos.userPassword = false;

            formLogin.reset();
            alertaExito.classList.add("alertaExito");
            alertaError.classList.remove("alertaError");
            setTimeout(() => {
                alertaExito.classList.remove("alertaExito");
            }, 3000);
            return;
        }

        alertaExito.classList.remove("alertaExito");
        alertaError.classList.add("alertaError");
        setTimeout(() => {
            alertaError.classList.remove("alertaError");
        }, 3000);
    }

})()

