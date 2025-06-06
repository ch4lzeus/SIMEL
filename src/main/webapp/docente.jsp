<%@ include file="Panel/head.jsp" %>
<body id="page-top">

    <div id="wrapper">
        <%@ include file="docente/secciones-docente.jsp" %>

        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <%@ include file="Panel/topbar.jsp" %>

                <!-- Contenido espec�fico del docente -->
                <%@ include file="docente/contenido-docente.jsp" %>
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

    <!-- c�digo alertas --> 
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- C�digo para notifiaciones -->
    <script src="js/notificaciones.js" type="text/javascript"></script>


    <!-------------------------------------------------Panel Docente --------------------------------------------------------------------->


    <!-- c�digo Mis cursos -->      
    <script src="js/js_docente/misCursos.js" type="text/javascript"></script>

    <!-- c�digo Ingresar Notas --> 
    <script src="js/js_docente/ingresarNotas.js" type="text/javascript"></script>

    <!-- c�digo Asignar Logros --> 
    <script src="js/js_docente/asignarLogros.js" type="text/javascript"></script>

    <!-- c�digo Ranking -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>

    <script src="js/js_docente/ranking.js" type="text/javascript"></script>

    
    <!-- c�digo Mensaje -->
    <script src="js/js_docente/mensaje.js" type="text/javascript"></script>

</body>
</html>
