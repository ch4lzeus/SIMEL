<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href=""> <!-- Aquí debes colocar el JSP o el destino que deseas mostrar en el icono -->
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-graduation-cap"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Centro Educativo 123<sup></sup></div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Gestión
    </div>

    <!-- Nav Item - Usuarios -->
    <li class="nav-item ${param.seccion == 'usuarios' ? 'active' : ''}">
        <a class="nav-link" href="administrador?seccion=usuarios"> <!-- Enlace al JSP correspondiente -->
            <i class="fas fa-user-plus"></i>  <!-- Representa claramente 'agregar usuario' -->
            <span>Usuarios</span>
        </a>
    </li>

    <!-- Nav Item - Cursos y Asignaciones -->
    <li class="nav-item ${param.seccion == 'cursosAsignaciones' ? 'active' : ''}">
        <a class="nav-link" href="administrador?seccion=cursosAsignaciones"> <!-- Enlace al JSP correspondiente -->
            <i class="fas fa-book-open"></i>  <!-- Representa cursos o aprendizaje -->
            <span>Cursos y Asignaciones</span>
        </a>
    </li>

    <!-- Nav Item - Logros y Premios -->
    <li class="nav-item ${param.seccion == 'logrosPremios' ? 'active' : ''}">
        <a class="nav-link" href="administrador?seccion=logrosPremios"> <!-- Enlace al JSP correspondiente -->
            <i class="fas fa-medal"></i>  <!-- Representa logros o premios -->
            <span>Logros y Premios</span>
        </a>
    </li>

    <!-- Nav Item - Canjes -->
    <li class="nav-item ${param.seccion == 'canjes' ? 'active' : ''}">
        <a class="nav-link" href="administrador?seccion=canjes"> <!-- Enlace al JSP correspondiente -->
            <i class="fas fa-gift"></i>  <!-- Representa un regalo o intercambio -->
            <span>Canjes</span>
        </a>
    </li>

    <!-- Nav Item - Reportes -->
    <li class="nav-item ${param.seccion == 'reportes' ? 'active' : ''}">
        <a class="nav-link" href="administrador?seccion=reportes"> <!-- Enlace al JSP correspondiente -->
            <i class="fas fa-chart-bar"></i>  <!-- Icono clásico de reportes -->
            <span>Reportes</span>
        </a>
    </li>

    <!-- Nav Item - Configuración -->
    <li class="nav-item ${param.seccion == 'retosadmin' ? 'active' : ''}">
        <a class="nav-link" href="administrador?seccion=retosadmin"> <!-- Enlace al JSP correspondiente -->
            <i class="fas fa-cogs"></i>
            <span>Gestión de Retos</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Desplazamiento del panel < > -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
