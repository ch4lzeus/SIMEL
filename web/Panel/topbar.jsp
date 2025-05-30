<!-- topbar.jsp -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>

    <!-- Logo de SIMEL como imagen, envuelto en un enlace para darle un estilo de logo si quieres -->
    <a href="#" class="navbar-brand d-lg-block" style="padding-left: 10px;">
        <img src="img/logo.svg" alt="Logo SIMEL" width="200" height="70">
    </a>
    <ul class="navbar-nav ml-auto">


        <!-- Ícono de Notificaciones (visible siempre) -->
        <li class="nav-item dropdown no-arrow">
            <!-- Cambia href por onclick para que ejecute la función de toggle correctamente -->
            <a class="nav-link" href="javascript:void(0);" onclick="toggleNotifications()">
                <i class="fa fa-bell" style="font-size: 24px; color: #004E92; background-color: white; border-radius: 50%; padding: 5px;"></i>
            </a>
        </li>

        <!-- Contenedor de Notificaciones -->
        <div id="notificationDrawer" class="notification-drawer">
            <div class="notification-header">
                <span>Notificaciones</span>
                <button onclick="toggleNotifications()">×</button>
            </div>
            <div class="notification-body">
                <!-- Aquí irían las notificaciones -->
                <p>No tienes notificaciones.</p>
            </div>
        </div>

        <!-- Separador (solo visible en pantallas medianas o grandes) -->
        <div class="topbar-divider d-none d-lg-block" style="border-left: 2px solid black;"></div>

        <!-- Usuario (oculto en pantallas pequeñas) -->
        <li class="nav-item dropdown no-arrow d-none d-lg-flex">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <div class="d-inline-block text-left">
                    <div style="font-size: 15px; color: black;">
                        Hola, <span class="font-weight-bold"><%= session.getAttribute("nombre")%></span>
                    </div>
                    <div style="margin-left: 40px; font-size: 14px; color: black;">
                        <%= session.getAttribute("rol")%>
                    </div>
                </div>
                <%
                    String rol = (String) session.getAttribute("rol");
                    String imgSrc = "img/admin.svg";

                    if ("alumno".equals(rol)) {
                        imgSrc = "img/student.svg";
                    } else if ("docente".equals(rol)) {
                        imgSrc = "img/teacher.svg";
                    } else if ("administrador".equals(rol)) {
                        imgSrc = "img/admin.svg";
                    }
                %>
                <img src="<%= imgSrc%>" alt="usuario" width="40px" style="margin-left: 10px;">
            </a>
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Cerrar Sesión
                </a>
            </div>
        </li>
    </ul>
</nav>
