<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>



<c:choose>

    <%-------------------------------------------------------------- Sesion 1 ----------------------------------------------------------------%>
    <c:when test="${seccion == 'usuarios'}">
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-administrador text-secondary d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Registro de usuarios</h5>
                    <i class="fas fa-trophy"></i>
                </div>

                <div class="container">
                    <br>  
                    <div class="row">
                        <div class="col-lg-12">            
                            <button id="btnNuevo" type="button" class="btn btn-secondary" data-toggle=@dal">Nuevo</button>    
                        </div>    
                    </div>    
                </div>    
                <br>  
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="table-responsive">        
                                <table id="tablaPersonas" class="table table-striped table-bordered table-condensed text-center" style="width:100%">
                                    <thead class="encabezado-gestionCanjes">
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
                                        <c:forEach var="usuario" items="${usuarios}">
                                            <tr>
                                                <td>${usuario.id}</td>
                                                <td>${usuario.nombre}</td>
                                                <td>${usuario.usuario}</td>
                                                <td>${usuario.contrasena}</td>                                        
                                                <td>${usuario.rol}</td>
                                                <td>${usuario.estado}</td>
                                                <td>${usuario.fechaCreacion}</td>
                                                <td></td>                                       
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>                 
                            </div>
                        </div>
                    </div> 
                </div>    
            </div>


            <div class="modal fade" id="modalCRUD" tabindex="-1" role="dialog" aria-labelledby="modalCRUDLabel" aria-hidden="true">
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

                            <input type="hidden" id="id" name="id">
                        </form>    
                    </div>
                </div>
            </div>  

        </div>

    </c:when>

    <%-------------------------------------------------------------- Sesion 2 ----------------------------------------------------------------%>

    <c:when test="${seccion == 'cursosAsignaciones'}">
        <div class="container mt-5">
            <section class="panel-asignacion animate__animated animate__fadeIn">
                <div class="card shadow-sm">
                    <div class="card-header bg-administrador text-secondary d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Administración de asignaturas</h5>
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <div class="card-body">


                        <ul class="nav nav-tabs mb-4" id="asignacionTabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="docentes-tab" data-toggle="tab" href="#docentes" role="tab" aria-controls="docentes" aria-selected="true">
                                    <i class="fas fa-user-tie"></i> Docentes
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="alumnos-tab" data-toggle="tab" href="#alumnos" role="tab" aria-controls="alumnos" aria-selected="false">
                                    <i class="fas fa-user-graduate"></i> Alumnos
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content" id="asignacionTabsContent">

                            <!-- Pestaña Docentes -->
                            <div class="tab-pane fade show active" id="docentes" role="tabpanel" aria-labelledby="docentes-tab">

                                <div class="card mb-4 shadow-sm">
                                    <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0"><i class="fas fa-chalkboard-teacher"></i> Asignar Curso y Grado a Docente</h5>
                                    </div>
                                    <div class="card-body">
                                        <form id="form-asignar-docente">
                                            <div class="form-group">
                                                <label for="docente-select">Seleccionar docente:</label>
                                                <select class="form-control" id="docente-select" name="id_docente" required>
                                                    <option value="">-- Selecciona --</option>
                                                    <c:forEach var="docente" items="${docentes}">
                                                        <option value="${docente.id}">${docente.nombre}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>

                                            <div class="form-group">
                                                <label for="curso-select">Seleccionar curso:</label>
                                                <select class="form-control" id="curso-select" name="id_curso" required>
                                                    <option value="">-- Selecciona --</option>
                                                    <c:forEach var="curso" items="${cursos}">
                                                        <option value="${curso.id}">${curso.nombre}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>

                                            <div class="form-group">
                                                <label for="grado-select">Seleccionar grado/sección:</label>
                                                <select class="form-control" id="grado-select" name="id_grado_seccion" required>
                                                    <option value="">-- Selecciona --</option>
                                                    <c:forEach var="gs" items="${gradosSeccion}">
                                                        <option value="${gs.id}">${gs.grado}° - ${gs.seccion}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>

                                            <button type="submit" class="btn btn-success shadow-sm">
                                                <i class="fas fa-plus-circle"></i> Asignar
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <div class="card border-left-secondary shadow-sm">
                                    <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0"><i class="fas fa-list"></i> Cursos Asignados a Docentes</h5>
                                    </div>
                                    <div class="card-body p-0">
                                        <ul id="cursos-asignados-docente" class="list-group lista-scroll mb-0">
                                            <c:forEach var="asignado" items="${cursosAsignados}">
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    ${asignado.docenteNombre} - ${asignado.cursoNombre} (${asignado.grado}° - ${asignado.seccion})
                                                    <span class="badge bg-success text-white">Asignado</span>
                                                </li>
                                            </c:forEach>
                                        </ul>

                                    </div>
                                </div>

                            </div>

                            <div class="tab-pane fade" id="alumnos" role="tabpanel" aria-labelledby="alumnos-tab">

                                <div class="card mb-4 shadow-sm">
                                    <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0"><i class="fas fa-user-graduate"></i> Asignar Grado a Alumno</h5>
                                    </div>
                                    <div class="card-body">
                                        <form id="form-asignar-alumno">
                                            <div class="form-group">
                                                <label for="alumno-select">Seleccionar alumno:</label>
                                                <select class="form-control" id="alumno-select" name="id_alumno" required>
                                                    <option value="">-- Selecciona --</option>
                                                    <c:forEach var="alumno" items="${alumnos}">
                                                        <option value="${alumno.id}">${alumno.nombre}</option>
                                                    </c:forEach>
                                                </select>


                                            </div>

                                            <div class="form-group">
                                                <label for="grado-seccion-select">Seleccionar grado/sección:</label>
                                                <select class="form-control" id="grado-seccion-select" name="id_grado_seccion" required>
                                                    <option value="">-- Selecciona --</option>
                                                    <c:forEach var="gs" items="${gradosSeccion}">
                                                        <option value="${gs.id}">${gs.grado}° - ${gs.seccion}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>

                                            <button type="submit" class="btn btn-success shadow-sm">
                                                <i class="fas fa-plus-circle"></i> Asignar
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <div class="card border-left-secondary shadow-sm">
                                    <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0"><i class="fas fa-list-alt"></i> Alumnos por Sección</h5>
                                    </div>
                                    <div class="card-body p-0">
                                        <ul id="alumnos-por-seccion" class="list-group lista-scroll mb-0">
                                            <c:forEach var="item" items="${resumenPorSeccion}">
                                                <li class="list-group-item">
                                                    <c:out value="${item}" escapeXml="false" />
                                                </li>
                                            </c:forEach>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

    </c:when>

    <%-------------------------------------------------------------- Sesion 3 ----------------------------------------------------------------%>
    <c:when test="${seccion == 'logrosPremios'}">
        <div class="container mt-5">
            <section class="panel-logros animate__animated animate__fadeIn">
                <div class="card shadow-sm">
                    <div class="card-header bg-docente text-gray d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Asignación y registro de logros</h5>
                        <i class="fas fa-award"></i>
                    </div>
                    <div class="card-body">


                        <div class="mb-4">
                            <label for="selectLogro" class="form-label">Seleccione un logro existente o escriba uno nuevo:</label>
                            <select id="selectLogro" class="form-control mb-3">
                                <option value="">-- Nuevo logro --</option>
                                <option value="1">Puntualidad</option>
                                <option value="2">Participación activa</option>

                            </select>

                            <input type="text" id="nombreLogro" class="form-control mb-2" placeholder="Nombre del logro" />
                            <textarea id="descripcionLogro" class="form-control mb-3" rows="2" placeholder="Descripción del logro" style="resize: none;"></textarea>

                            <button id="btnGuardarLogro" class="btn btn-success">
                                <i class="fas fa-save"></i> Guardar
                            </button>

                        </div>

                        <hr>


                        <h5>Logros creados/asignados</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle">
                                <thead class="encabezado-logros">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaLogrosDocenteBody">

                                    <tr>
                                        <td>1</td>
                                        <td>Puntualidad</td>
                                        <td>Llega a tiempo a clases</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary btnEditar" data-id="1">
                                                <i class="fas fa-edit"></i> Editar
                                            </button>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Participación activa</td>
                                        <td>Interviene frecuentemente en clase</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary btnEditar" data-id="1">
                                                <i class="fas fa-edit"></i> Editar
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>


    </c:when>

    <%-------------------------------------------------------------- Sesion 4 ----------------------------------------------------------------%>
    <c:when test="${seccion == 'canjes'}">
        <div class="container mt-5">
            <section class="panel-gestionPremios animate__animated animate__fadeIn">
                <div class="card shadow-sm">
                    <div class="card-header bg-admin text-gray d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Historial y control de canjes</h5>
                        <i class="fas fa-gift"></i>
                    </div>
                    <div class="card-body">


                        <div class="mb-4">
                            <input type="hidden" id="premioId" value="" />

                            <input type="text" id="nombrePremio" class="form-control mb-2" placeholder="Nombre del premio" />

                            <textarea id="descripcionPremio" class="form-control mb-2" rows="2" placeholder="Descripción del premio" style="resize: none;"></textarea>

                            <input type="number" id="puntosPremio" class="form-control mb-2" placeholder="Puntos requeridos" min="0" />

                            <select id="tipoPremio" class="form-control mb-2">
                                <option value="">Seleccione tipo</option>
                                <option value="físico">Físico</option>
                                <option value="digital">Digital</option>
                            </select>

                            <label class="form-label">Imagen del premio</label>


                            <div class="custom-file-upload mb-2 d-flex justify-content-center">
                                <label for="archivoImagenPremio" class="upload-btn text-center">
                                    <i class="fas fa-upload me-2"></i> Elegir imagen
                                </label>
                                <input type="file" id="archivoImagenPremio" accept="image/*" />
                            </div>

                            <div id="previewImagenPremio" class="mb-3"></div>

                            <button id="btnGuardarPremio" class="btn btn-success">
                                <i class="fas fa-gift"></i> Guardar
                            </button>

                            <button id="btnCancelarEdicion" class="btn btn-secondary" style="display:none;">Cancelar</button>
                        </div>

                        <hr />

                        <h5>Premios creados</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle">
                                <thead class="encabezado-gestionCanjes">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Puntos</th>
                                        <th>Tipo</th>
                                        <th>Imagen</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaPremiosBody">

                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </section>
        </div>


    </c:when>

    <%-------------------------------------------------------------- Sesion 5 ----------------------------------------------------------------%>

    <c:when test="${seccion == 'reportes'}">
        <div class="container mt-5">
            <section id="seccion-reportes" class="reportes">
                <div class="card shadow-sm">
                    <div class="card-header bg-admintrador text-gray d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Panel de Reportes</h5>
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="card-body">


                        <div class="reporte-selector mb-4">
                            <label for="tipo-reporte">Selecciona tipo de reporte:</label>
                            <select id="tipo-reporte" class="form-control">
                                <option value="alumnos">🎓 Alumnos - Ranking por puntos</option>
                                <option value="docentes">👩‍🏫 Docentes - Uso del sistema</option>
                                <option value="canjes">🎁 Canjes realizados</option>
                            </select>
                            <button id="btn-generar-reporte" class="btn btn-secondary mt-2">
                                <i class="fas fa-chart-line"></i> Generar
                            </button>
                        </div>


                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle">
                                <thead class="encabezado-reportes">
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


                        <div class="acciones-reporte mt-4 d-flex justify-content-center gap-3">
                            <button class="btn btn-danger" id="btn-exportar-pdf">
                                <i class="fas fa-file-pdf"></i> Generar PDF
                            </button>
                            <button class="btn btn-success" id="btn-exportar-excel">
                                <i class="fas fa-file-excel"></i> Exportar Excel
                            </button>
                            <button class="btn btn-info" id="btn-imprimir">
                                <i class="fas fa-print"></i> Imprimir
                            </button>
                        </div>

                    </div>
                </div>
            </section>
        </div>

    </c:when>


    <%-------------------------------------------------------------- Sesion 6 ----------------------------------------------------------------%>

    <c:when test="${seccion == 'retosadmin'}">
        <div class="container mt-5">
            <section id="seccion-reportes" class="reportes">
                <div class="card shadow-sm">
                    <div class="card-header bg-admintrador text-gray d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Desafíos académicos</h5>
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="card-body">

                        <form id="formCrearReto">
                            <div class="form-group">
                                <label for="nombreReto">Nombre del reto</label>
                                <input type="text" class="form-control" id="nombreReto" required>
                            </div>

                            <div class="form-group mt-3">
                                <label for="descripcionReto">Descripción</label>
                                <textarea class="form-control" id="descripcionReto" rows="2" style="resize: none;"></textarea>
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

                            <button type="submit" class="btn btn-secondary mt-2">
                                <i class="fas fa-bolt"></i> Crear
                            </button>


                            <button id="btnCancelarEdicionReto" class="btn btn-outline-secondary mt-2" style="display: none;">
                                Cancelar edición
                            </button>


                        </form>

                        <hr>

                        <h5>Retos creados</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle">
                                <thead class="encabezado-gestionRetos">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Fecha límite</th>
                                        <th>Puntos</th>
                                        <th>Grado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaRetosBody">

                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </section>
        </div>

    </c:when>
</c:choose>