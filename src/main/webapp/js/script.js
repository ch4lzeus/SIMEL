const btnSignIn = document.getElementById("sign-in"),
        btnSignUp = document.getElementById("sign-up"),
        containerFormLogin = document.querySelector(".login");

btnSignIn.addEventListener("click", e => {
    containerFormLogin.classList.remove("hide")
})


btnSignUp.addEventListener("click", e => {
    containerFormLogin.classList.add("hide");
})




