<%@ include file="Panel/head.jsp" %>
<body id="page-top">

    <div id="wrapper">
        <%@ include file="alumno/secciones-alumno.jsp" %>

        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <%@ include file="Panel/topbar.jsp" %>

                <!-- Contenido espec�fico del docente -->
                <%@ include file="alumno/contenido-alumno.jsp" %>
            </div>

            <%@ include file="Panel/footer.jsp" %>
        </div>

        <%@ include file="Panel/logoutModal.jsp" %>

    </div> 
    <!-- Bootstrap core JavaScript-->
    <script src="js/jquery.min.js" type="text/javascript"></script>

    <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    <!-- Core plugin JavaScript-->

    <script src="js/jquery.easing.min.js" type="text/javascript"></script>
    <!-- Custom scripts for all pages-->

    <script src="js/sb-admin-2.min.js" type="text/javascript"></script>

    <!-- datatables JS -->
    <script src="js/datatables.min.js" type="text/javascript"></script>
    <!-- c�digo propio JS --> 
    <script src="js/main.js" type="text/javascript"></script>


    <!-- Librer�a para alertas -->

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Librer�a para el gr�fico -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <!-- Bootstrap JS (versi�n 5.x) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- C�digo para notifiaciones -->
    <script src="js/notificaciones.js" type="text/javascript"></script>

    <!------------------------------------------------ Panel Alumno ---------------------------------------------------------------------->

    <!-- Secci�n Mis cursos -->
    <script src="js/js_alumno/misCursos.js" type="text/javascript"></script>

    <!-- Secci�n Mis Notas -->
    <script src="js/js_alumno/misNotas.js" type="text/javascript"></script>

    <!-- Secci�n Logros -->
    <script src="js/js_alumno/logros.js" type="text/javascript"></script>

    <!-- Secci�n Canjes -->
    <script src="js/js_alumno/canjes.js" type="text/javascript"></script>

    <!-- Secci�n Retos -->    
    <script src="js/js_alumno/retos.js" type="text/javascript"></script>
</body>
</html>
