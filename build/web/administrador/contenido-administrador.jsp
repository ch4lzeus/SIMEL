<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.List" %>
<%@ page import="Servlets_administrador.Usuario" %>
<%@ page import="modelo.admin.Docente" %>
<%@ page import="modelo.admin.Curso" %>
<%@ page import="modelo.admin.AsignacionCurso" %>
<%@ page import="modelo.admin.AlumnosPorSeccion" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    String seccion = (String) request.getAttribute("seccion");
    if (seccion == null || seccion.isEmpty()) {
        seccion = "usuarios"; // o la que quieras por defecto
    }
%>



<!------------------------------------------- SECCION 1 ----------------------------------------------------> 

<% if ("usuarios".equals(seccion)) { %>
<!-- INICIO del contenido de la gestión de usuarios -->
<div class="container">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">            
                <button id="btnNuevo" type="button" class="btn btn-secondary" data-toggle="modal">Nuevo</button>    
            </div>    
        </div>    
    </div>    
    <br>  
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">        
                    <table id="tablaPersonas" class="table table-striped table-bordered table-condensed" style="width:100%">
                        <thead class="text-center">
                            <tr>
                                <th>Id</th>
                                <th>Nombre</th>
                                <th>Usuario</th>                                 
                                <th>Contraseña</th>
                                <th>Cargo</th>
                                <th>Estado</th>
                                <th>Fecha de creación</th> 
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Suponiendo que "usuarios" es una lista de objetos Usuario que has pasado como atributo
                                List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");
                                if (lista != null) {
                                    for (Usuario u : lista) {
                            %>
                            <tr>
                                <td><%= u.getId()%></td>
                                <td><%= u.getNombre()%></td>
                                <td><%= u.getUsuario()%></td>
                                <td><%= u.getContrasena()%></td>
                                <td><%= u.getRol()%></td>
                                <td><%= u.getEstado()%></td>
                                <td><%= u.getFechaCreacion()%></td>
                                <td></td> <!-- Aquí irían los botones de editar o eliminar -->
                            </tr>
                            <%
                                    }
                                }
                            %>                             
                        </tbody>        
                    </table>                    
                </div>
            </div>
        </div> 
    </div>    
    <!-- Modal para CRUD -->
    <div class="modal fade" id="modalCRUD" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <form id="formPersonas">    
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="nombre" class="col-form-label">Nombre:</label>
                            <input type="text" class="form-control" id="nombre" required>
                        </div>
                        <div class="form-group">
                            <label for="usuario" class="col-form-label">Usuario:</label>
                            <input type="text" class="form-control" id="usuario" required readonly>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-form-label">Contraseña:</label>
                            <input type="password" class="form-control" id="password" required>
                        </div>
                        <div class="form-group">
                            <label for="cargo" class="col-form-label">Cargo:</label>
                            <select class="form-control" id="cargo" required>   
                                <option value="alumno">Alumno</option>
                                <option value="docente">Docente</option>
                                <option value="administrador">Administrador</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="estado" class="col-form-label">Estado:</label>
                            <select class="form-control" id="estado" required>
                                <option value="activo">Activo</option>         
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-dismiss="modal">Cancelar</button>
                        <button type="submit" id="btnGuardar" class="btn btn-dark">Guardar</button>
                    </div>
                    <!-- Este campo no se ve en pantalla, pero es necesario para pasar el id al backend -->
                    <input type="hidden" id="id" name="id">
                </form>    
            </div>
        </div>
    </div>  
</div>     


<!------------------------------------------- SECCION 2 ---------------------------------------------------->                            
<% } else if ("cursosAsignaciones".equals(seccion)) { %>
<div class="container">
    <div class="container mt-5 animate__animated animate__fadeIn" id="seccion-cursos-asignaciones">

        <!-- Asignación de Cursos a Docentes -->
        <div class="card shadow mb-4 border-left-primary">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-chalkboard-teacher"></i> Asignación de Cursos a Docentes</h5>
            </div>
            <div class="card-body">
                <form id="form-asignar-docente">
                    <div class="form-group">
                        <label for="docente-select">Seleccionar docente:</label>
                        <select class="form-control" id="docente-select" name="id_docente" required>
                            <option value="">-- Selecciona --</option>
                            <%
                                List<modelo.admin.Docente> docentes = (List<modelo.admin.Docente>) request.getAttribute("docentes");
                                if (docentes != null) {
                                    for (modelo.admin.Docente d : docentes) {
                            %>
                            <option value="<%= d.getIdDocente()%>"><%= d.getNombre()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>

                    </div>

                    <!-- CURSOS DISPONIBLES -->
                    <div class="form-group mt-3">
                        <label>Cursos disponibles:</label>
                        <%
                            List<modelo.admin.Curso> cursos = (List<modelo.admin.Curso>) request.getAttribute("cursos");
                            if (cursos != null) {
                                for (modelo.admin.Curso curso : cursos) {
                        %>
                        <div class="form-check">
                            <input class="form-check-input curso-checkbox" type="checkbox" name="cursos" 
                                   value="<%= curso.getId()%>" id="curso-<%= curso.getId()%>">
                            <label class="form-check-label" for="curso-<%= curso.getId()%>">
                                <%= curso.getNombre()%>
                            </label>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>

                    <button type="submit" class="btn btn-success mt-3 shadow-sm" id="asignar-docente">
                        <i class="fas fa-plus-circle"></i> Asignar cursos
                    </button>
                </form>

                <hr>

                <h6><i class="fas fa-check-circle text-success"></i> Cursos ya asignados:</h6>
                <ul id="cursos-asignados-docente" class="list-group mt-2">
                    <%
                        List<AsignacionCurso> asignaciones = (List<AsignacionCurso>) request.getAttribute("cursosAsignados");
                        if (asignaciones != null && !asignaciones.isEmpty()) {
                            for (AsignacionCurso a : asignaciones) {
                    %>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <%= a.getNombreCurso()%> - <%= a.getNombreDocente()%> 
                        <span class="badge badge-success">Activo</span>
                    </li>
                    <%
                        }
                    } else {
                    %>
                    <li class="list-group-item">No hay cursos asignados.</li>
                        <%
                            }
                        %>
                </ul>
            </div>
        </div>

        <!-- Asignación de Cursos a Alumnos -->
        <div class="card shadow border-left-info">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0"><i class="fas fa-user-graduate"></i> Asignación de Cursos a Alumnos</h5>
            </div>
            <div class="card-body">
                <form id="form-asignar-alumno">
                    <div class="form-group">
                        <label for="alumno-select">Seleccionar alumno:</label>
                        <select class="form-control" id="alumno-select" name="id_alumno" required>
                            <option value="">-- Selecciona --</option>
                            <%
                                List<modelo.admin.Alumno> alumnos = (List<modelo.admin.Alumno>) request.getAttribute("alumnos");
                                if (alumnos != null) {
                                    for (modelo.admin.Alumno a : alumnos) {
                            %>
                            <option value="<%= a.getIdAlumno()%>"><%= a.getNombre()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>

                    </div>

                    <div class="form-group mt-3">
                        <label for="grado-select">Grado/Sección:</label>
                        <select class="form-control" id="grado-select" name="grado_seccion">
                            <option value="4A">4to -  A</option>
                            <option value="4B">5to - A</option>
                            <option value="4B">6to - A</option>
                        </select>
                    </div>
                    <div class="mt-4">
                        <h6><i class="fas fa-edit text-warning"></i> Asignación manual:</h6>
                        <%
                            if (cursos != null) {

                                for (modelo.admin.Curso curso : cursos) {
                        %>
                        <div class="form-check">
                            <input class="form-check-input curso-checkbox-manual" type="checkbox" name="cursos_manual"
                                   value="<%= curso.getId()%>" id="curso-<%= curso.getId()%>">
                            <label class="form-check-label" for="curso-<%= curso.getId()%>">
                                <%= curso.getNombre()%>
                            </label>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>


                    <button type="submit" class="btn btn-warning mt-3 shadow-sm" id="actualizar-alumno">
                        <i class="fas fa-sync-alt"></i> Actualizar cursos
                    </button>
                </form>

                <hr>

                <h6><i class="fas fa-history text-secondary"></i> Alumnos por Sección:</h6>
                <ul id="historial-academico" class="list-group mt-2">
                    <%
                        List<modelo.admin.AlumnosPorSeccion> lista = (List<modelo.admin.AlumnosPorSeccion>) request.getAttribute("alumnosPorSeccion");
                        if (lista != null && !lista.isEmpty()) {
                            for (modelo.admin.AlumnosPorSeccion item : lista) {
                    %>
                    <li class="list-group-item">
                        Sección: <strong><%= item.getGrado() + " - " + item.getSeccion()%></strong> - Total alumnos: <strong><%= item.getTotalAlumnos()%></strong>
                    </li>
                    <%
                        }
                    } else {
                    %>
                    <li class="list-group-item">No hay datos de alumnos disponibles.</li>
                        <%
                            }
                        %>
                </ul>

            </div>
        </div>
    </div>
</div>



<!------------------------------------------- SECCION 3 ----------------------------------------------------> 
<% } else if ("logrosPremios".equals(seccion)) { %>
<div class="container">
    <section class="config-logros container mt-5 animate__animated animate__fadeIn">
        <!-- Botones de acción -->
        <div class="acciones-logros mb-3 d-flex flex-wrap gap-2">
            <button class="btn btn-success" id="btn-crear-logro">
                <i class="fas fa-plus-circle"></i> Crear nuevo logro
            </button>
            <button class="btn btn-secondary" id="btn-criterios-logros">
                <i class="fas fa-cogs"></i> Criterios automáticos
            </button>
        </div>

        <!-- Tabla de logros -->
        <div class="table-responsive">
            <table class="table table-bordered tabla-logros shadow-sm">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Icono</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Puntos</th>
                        <th>Periodo</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="tabla-logros-body" class="text-center align-middle">
                    <tr data-id-logro="1">
                        <td>🏅</td>
                        <td>Logro Académico</td>
                        <td>Promedio mayor a 15</td>
                        <td><span class="badge bg-primary">+20 pts</span></td>
                        <td>2025-I</td>
                        <td>
                            <input type="checkbox" checked title="Habilitado" class="toggle-estado-logro" />
                        </td>
                        <td>
                            <button class="btn btn-outline-primary btn-sm btn-editar-logro" data-id="1">
                                <i class="fas fa-edit"></i> Editar
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Vista previa de medallas -->
        <h4 class="mt-5">
            <i class="fas fa-medal text-warning"></i> Vista previa de medallas
        </h4>
        <div id="medallas-preview" class="medallas-preview d-flex flex-wrap justify-content-center gap-3 mt-3">
            <div class="medalla" title="Promedio mayor a 15">🏅 Logro Académico</div>
            <div class="medalla" title="Participó en 5 foros">🎯 Participación activa</div>
            <div class="medalla" title="Completó todas las lecturas">📚 Lectura completa</div>
        </div>
    </section>
</div>





<!------------------------------------------- SECCION 4 ----------------------------------------------------> 
<% } else if ("canjes".equals(seccion)) { %>
<div class="container">
    <section class="panel-canjes container mt-5 ">
        <!-- Botones de acción -->
        <div class="acciones-canjes mb-3">
            <button class="btn btn-success me-2" onclick="agregarPremio()">➕ Agregar premio</button>
            <button class="btn btn-secondary" onclick="verHistorial()">📜 Ver historial</button>
        </div>

        <!-- Filtros -->
        <div class="filtros-canjes mb-4 d-flex gap-3">
            <div>
                <label for="filtro-curso" class="form-label">Curso:</label>
                <select id="filtro-curso" class="form-select">
                    <option value="">Todos</option>
                    <option value="matematica">Matemática</option>
                    <option value="historia">Historia</option>
                    <!-- Estos valores se harán dinámicos después -->
                </select>
            </div>

            <div>
                <label for="filtro-alumno" class="form-label">Alumno:</label>
                <select id="filtro-alumno" class="form-select">
                    <option value="">Todos</option>
                    <option value="juan">Juan Pérez</option>
                    <option value="maria">María Gómez</option>
                    <!-- También se volverán dinámicos después -->
                </select>
            </div>
        </div>

        <!-- Tabla de premios/canjes -->
        <table class="table table-bordered tabla-canjes">
            <thead class="table-dark">
                <tr>
                    <th>Premio</th>
                    <th>Descripción</th>
                    <th>Puntos</th>
                    <th>Entregado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="tabla-canjes-body">
                <tr>
                    <td>📚 Cuaderno</td>
                    <td>Cuaderno con diseño personalizado</td>
                    <td>30</td>
                    <td>
                        <select class="form-select form-select-sm">
                            <option>Pendiente</option>
                            <option>Entregado</option>
                        </select>
                    </td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="editarPremio(this)">✏️ Editar</button>
                    </td>
                </tr>
                <tr>
                    <td>🍫 Chocolate</td>
                    <td>Barra de chocolate</td>
                    <td>10</td>
                    <td>
                        <select class="form-select form-select-sm" disabled>
                            <option>Pendiente</option>
                            <option>Entregado</option>
                        </select>
                    </td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="editarPremio(this)">✏️ Editar</button>
                    </td>
                </tr>
                <!-- Más filas serán agregadas dinámicamente por JS -->
            </tbody>
        </table>
    </section>
</div>



<!------------------------------------------- SECCION 5 ----------------------------------------------------> 
<% } else if ("reportes".equals(seccion)) { %>
<div class="container">
    <section id="seccion-reportes" class="reportes mt-5">
        <!-- Selector de tipo de reporte -->
        <div class="reporte-selector mb-4">
            <label for="tipo-reporte">Selecciona tipo de reporte:</label>
            <select id="tipo-reporte" class="form-control">
                <option value="cursos">📘 Cursos - Promedios generales</option>
                <option value="alumnos">🎓 Alumnos - Ranking por puntos</option>
                <option value="docentes">👩‍🏫 Docentes - Uso del sistema</option>
                <option value="canjes">🎁 Canjes realizados</option>
            </select>
            <button id="btn-generar-reporte" class="btn btn-primary mt-2">🔍 Generar</button>
        </div>

        <!-- Contenedor dinámico para la tabla generada -->
        <div id="contenedor-tabla-reporte" class="tabla-reporte">
            <table id="tabla-reporte" class="table table-bordered">
                <thead>
                    <tr>
                        <th>Curso</th>
                        <th>Promedio</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Matemática</td>
                        <td>16.5</td>
                    </tr>
                    <tr>
                        <td>Historia</td>
                        <td>15.2</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Acciones sobre el reporte generado -->
        <div class="acciones-reporte mt-4 d-flex gap-3">
            <button class="btn btn-danger" id="btn-exportar-pdf">📄 Exportar PDF</button>
            <button class="btn btn-success" id="btn-exportar-excel">📊 Exportar Excel</button>
            <button class="btn btn-secondary" id="btn-imprimir">🖨️ Imprimir</button>
        </div>
    </section>
</div>



<!------------------------------------------- SECCION 6 ----------------------------------------------------> 
<% } else if ("retosadmin".equals(seccion)) { %>
<div class="container mt-5">
    <section class="panel-retosadmin animate__animated animate__fadeIn">
  <h3>🛠️ Crear Nuevo Reto</h3>

  <form id="formCrearReto" >
    <div class="form-group">
      <label for="nombreReto">Nombre del reto</label>
      <input type="text" class="form-control" id="nombreReto" required>
    </div>

    <div class="form-group mt-3">
      <label for="descripcionReto">Descripción</label>
      <textarea class="form-control" id="descripcionReto" rows="2" required></textarea>
    </div>

    <div class="form-group mt-3">
      <label for="fechaLimite">Fecha límite</label>
      <input type="date" class="form-control" id="fechaLimite" required>
    </div>

    <div class="form-group mt-3">
      <label for="puntosReto">Puntos</label>
      <input type="number" class="form-control" id="puntosReto" required>
    </div>

    <div class="form-group mt-3">
      <label for="gradoReto">Grado al que va dirigido</label>
      <select class="form-control" id="gradoReto" required>
        <option value="">Seleccione un grado</option>
        <option value="4to">4to</option>
        <option value="5to">5to</option>
        <option value="6to">6to</option>
      </select>
    </div>

    <button type="submit" class="btn btn-primary mt-4">Crear Reto</button>
  </form>
    </section>
</div>

<% }%>
