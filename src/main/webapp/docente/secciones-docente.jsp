<nav class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Marca del sitio -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-graduation-cap"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Centro Educativo 123</div>
    </a>

    <!-- Divisores y encabezados -->
    <hr class="sidebar-divider my-0">
    <hr class="sidebar-divider">
    <div class="sidebar-heading">Categorías</div>

    <!-- Menú de navegación -->
    <ul class="nav flex-column">
        <li class="nav-item ${param.seccion == 'misCursos' ? 'active' : ''}">
            <a class="nav-link" href="docente?seccion=misCursos">
                <i class="fas fa-book-open"></i>
                <span>Mis Cursos</span>
            </a>
        </li>
        <li class="nav-item ${param.seccion == 'ingresarNotas' ? 'active' : ''}">
            <a class="nav-link" href="docente?seccion=ingresarNotas">
                <i class="fas fa-pen"></i>
                <span>Ingresar Notas</span>
            </a>
        </li>
        <li class="nav-item ${param.seccion == 'asignarLogros' ? 'active' : ''}">
            <a class="nav-link" href="docente?seccion=asignarLogros">
                <i class="fas fa-award"></i>
                <span>Asignar Logros</span>
            </a>
        </li>
        <li class="nav-item ${param.seccion == 'rankingEstudiantes' ? 'active' : ''}">
            <a class="nav-link" href="docente?seccion=rankingEstudiantes">
                <i class="fas fa-chart-bar"></i>
                <span>Ranking de Estudiantes</span>
            </a>
        </li>
        <li class="nav-item ${param.seccion == 'retosEstudiantes' ? 'active' : ''}">
            <a class="nav-link" href="docente?seccion=retosEstudiantes">
                <i class="fas fa-tasks"></i>
                <span>Retos de Estudiantes</span>
            </a>
        </li>
    </ul>

    <!-- Final del sidebar -->
    <hr class="sidebar-divider d-none d-md-block">
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</nav>
