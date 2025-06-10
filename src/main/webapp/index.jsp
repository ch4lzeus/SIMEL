<!doctype html>
<html>
    <head>
        <link rel="shortcut icon" href="#" />
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Login SIMEL</title>
        <!-- Letra y casillas -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!-- Color de todo el estilo -->
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
        <link href="css/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/material-design-iconic-font.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/loader.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container-login">
            <div class="login-box">
                <!-- Columna del colegio -->
                <div class="institution-box">
                    <img src="img/logo.svg" alt="login" class="institution-title">
                    <!-- <p class="institution-subtitle">Sistema de Incentivo y Motivación para estudiantes de Lima</p>-->
                    <img src="img/login.svg" alt="Estudiantes" class="institution-image">
                </div>
                <!-- Columna del formulario -->
                <div class="wrap-login">
                    <form class="login-form validate-form" id="formLogin" action="LoginServlet" method="post">
                        <span class="login-form-title">Login</span>
                        <div class="wrap-input100" data-validate="Usuario incorrecto">
                            <input class="input100" type="text" id="usuario" name="usuario" placeholder="Usuario">
                            <span class="focus-efecto"></span>
                        </div>
                        <div class="wrap-input100" data-validate="Password incorrecto">
                            <input class="input100" type="password" id="password" name="password" placeholder="Password">
                            <span class="focus-efecto"></span>
                        </div>
                        <div class="container-login-form-btn">
                            <div class="wrap-login-form-btn">
                                <div class="login-form-bgbtn"></div>
                                <button type="submit" name="submit" class="login-form-btn">CONECTAR</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>             
        <%@ include file="Panel/leader.jsp" %>
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/sweetalert2.all.min.js"></script>
        <script src="js/codigo.js"></script>
    </body>
</html>