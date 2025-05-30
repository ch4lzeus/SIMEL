import { validarCampo, userRegex, passwordRegex, estadoValidacionCampos, enviarFormulario} from "./register.js";

const formLogin = document.querySelector(".form-login");
const inputPass = document.querySelector('.form-login input[type="password"]');
const inputUser = document.querySelector('.form-login input[type="user"]');
const alertaErrorLogin = document.querySelector(".form-login .alerta-error");
const alertaExitoLogin = document.querySelector(".form-login .alerta-exito");

document.addEventListener("DOMContentLoaded", () => {
    formLogin.addEventListener("submit", (e) => {
        estadoValidacionCampos.userName = true;
        e.preventDefault();
        enviarFormulario(formLogin, alertaErrorLogin, alertaExitoLogin);
    });

    inputUser.addEventListener("input", () => {
        validarCampo(userRegex, inputUser, "El correo solo puede contener letras, números, puntos, guiones y guíon bajo.");
    });

    inputPass.addEventListener("input", () => {
        validarCampo(passwordRegex, inputPass, "La contraseña tiene que ser de 4 a 12 dígitos");
    });
});