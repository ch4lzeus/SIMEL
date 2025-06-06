<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>


<c:choose>

    <c:when test="${seccion == 'misCursos'}">
        <div class="container mt-5">
            <section class="panel-docente panel-cursos animate__animated animate__fadeIn">
                <div class="card shadow-sm">
                    <div class="card-header bg-docente text-info d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Vista general de asignaturas</h5>
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle tabla-cursos">
                                <thead class="encabezado-tabla-cursos">
                                    <tr>
                                        <th>Código</th>
                                        <th>Nombre del Curso</th>
                                        <th>Grado</th>
                                        <th>Sección</th>
                                        <th>Total de Alumnos</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="curso" items="${cursosAsignados}">
                                        <tr>
                                            <td>C${curso.idCurso}</td>
                                            <td>${curso.nombreCurso}</td>
                                            <td>${curso.grado}°</td>
                                            <td>${curso.seccion}</td>
                                            <td>${curso.totalAlumnos}</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info btn-ver-alumnos"
                                                        data-curso="${curso.nombreCurso}"
                                                        data-grado="${curso.grado}°"
                                                        data-seccion="${curso.seccion}">
                                                    <i class="fas fa-users"></i> Ver Alumnos
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>

    </c:when>


    <c:when test="${seccion == 'ingresarNotas'}">
        <div class="container mt-5">
            <section class="panel-docente panel-notas animate__animated animate__fadeIn">
                <div class="card shadow-sm">     
                    <div class="card-header bg-docente text-info d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Registro de Evaluaciones Académicas</h5>
                        <i class="fas fa-clipboard-list"></i>
                    </div>    
                    <div class="card-body">


                        <div class="mb-4">
                            <label for="selectCurso" class="form-label">Selecciona una materia y sección:</label>
                            <select id="selectCurso" class="form-control select-curso-notas">
                                <option disabled selected>-- Selecciona --</option>
                                <option value="matematica-4A">Matemática - 4°A</option>
                                <option value="historia-5B">Historia - 5°B</option>
                            </select>
                        </div>


                        <div id="tablaNotasContainer" style="display: none;">
                            <div class="table-responsive">
                                <table class="table table-bordered text-center align-middle tabla-notas">
                                    <thead class="encabezado-tabla-notas">
                                        <tr>
                                            <th>Alumno</th>
                                            <th>Eval. 1</th>
                                            <th>Eval. 2</th>
                                            <th>Eval. 3</th>
                                            <th>Promedio</th>
                                            <th>Comentario</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tablaNotasBody">

                                    </tbody>
                                </table>
                            </div>

                            <div class="text-end mt-3">
                                <button class="btn btn-info" onclick="guardarNotas()">💾 Guardar Notas</button>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </div>

    </c:when>


    <c:when test="${seccion == 'asignarLogros'}">
        <div class="container mt-5">
            <section class="panel-logros animate__animated animate__fadeIn">
                <div class="card shadow-sm">

                    <div class="card-header bg-docente text-info d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Asignación de logros académicos</h5>
                        <i class="fas fa-award"></i>
                    </div>

                    <div class="card-body">

                        <form id="formLogro" onsubmit="return asignarLogro(event)">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="selectCurso" class="form-label label-curso-logros">Curso:</label>
                                    <select id="selectCurso" class="form-select select-curso-logros">
                                        <option selected disabled>-- Selecciona un curso --</option>
                                        <option value="matematica-4A">Matemática - 4°A</option>
                                        <option value="historia-5B">Historia - 5°B</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="selectAlumno" class="form-label label-alumno-logros">Alumno:</label>
                                    <select id="selectAlumno" class="form-select select-alumno-logros" disabled>
                                        <option selected disabled>-- Selecciona un alumno --</option>
                                    </select>
                                </div>
                            </div>


                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <label for="selectTipoLogro" class="form-label label-tipo-logro">Tipo de logro:</label>
                                    <select id="selectTipoLogro" class="form-select select-tipo-logro">
                                        <option selected disabled>-- Selecciona un logro --</option>
                                    </select>
                                </div>
                            </div>


                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="puntos" class="form-label label-puntos-logro">Puntos:</label>
                                    <input type="number" id="puntos" class="form-control input-puntos-logro" min="1" max="100" placeholder="Ej. 10">
                                </div>
                                <div class="col-md-8">
                                    <label for="comentario" class="form-label label-comentario-logro">Comentario:</label>
                                    <textarea id="comentario" class="form-control textarea-comentario-logro" rows="1" placeholder="Comentario opcional"></textarea>
                                </div>
                            </div>
                            <div class="text-end">
                                <button type="submit" class="btn bg-info text-white btn-asignar-logro">
                                    <i class="fas fa-plus-circle"></i> Asignar logro 
                                </button>
                            </div>
                        </form>


                        <hr class="my-4">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">📜 Historial de Logros</h5>
                            <input type="text" id="filtroHistorial" class="form-control w-25 filtro-historial-logros" placeholder="Filtrar por curso o fecha">
                        </div>

                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle tabla-historial-logros" id="tablaHistorial">
                                <thead class="encabezado-tabla-logros">
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Curso</th>
                                        <th>Alumno</th>
                                        <th>Logro</th>
                                        <th>Puntos</th>
                                        <th>Comentario</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>2025-05-01</td>
                                        <td>Matemática - 4°A</td>
                                        <td>Luis Chalan</td>
                                        <td>Participación destacada</td>
                                        <td>10</td>
                                        <td>Muy participativo en clase</td>
                                    </tr>
                                    <tr>
                                        <td>2025-05-12</td>
                                        <td>Historia - 5°B</td>
                                        <td>Marisol Fernández</td>
                                        <td>Mejor asistencia</td>
                                        <td>8</td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </section>
        </div>
    </c:when>



    <c:when test="${seccion == 'rankingEstudiantes'}">
        <div class="container mt-5">
            <section class="panel-ranking animate__animated animate__fadeIn">
                <div class="card shadow-sm"> <!-- ✅ Encabezado con fondo verde y el ícono -->
                    <div class="card-header bg-docente text-info d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Ranking de alumnos</h5>
                        <i class="fas fa-trophy"></i>
                    </div>
                    <div class="card-body">
                        <!-- Botones de acción -->
                        <div class="d-flex justify-content-end mb-3">
                            <button class="btn btn-success me-2 btn-exportar-ranking">
                                <i class="fas fa-file-excel"></i> Exportar Excel
                            </button>

                            <button class="btn btn-danger btn-generar-pdf">
                                <i class="fas fa-file-pdf"></i> Generar PDF
                            </button>

                        </div>

                        <!-- Tabla de Ranking -->
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle tabla-ranking" id="tablaRanking">
                                <thead class="encabezado-ranking">
                                    <tr>
                                        <th>#</th>
                                        <th>Nombre del Alumno</th>
                                        <th>Total de Puntos</th>
                                        <th>Medalla</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Luis Chalan</td>
                                        <td>85</td>
                                        <td><span class="medalla oro">🥇 Oro</span></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Marisol Fernández</td>
                                        <td>60</td>
                                        <td><span class="medalla plata">🥈 Plata</span></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Pedro Valverde</td>
                                        <td>40</td>
                                        <td><span class="medalla bronce">🥉 Bronce</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </section>
        </div>
    </c:when>





    <c:when test="${seccion == 'retosEstudiantes'}">
        <div class="container mt-5">
            <section class="panel-retosEstudiantes animate__animated animate__fadeIn">
                <div class="card shadow-sm">
                    <div class="card-header bg-docente text-info d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Retos Pendientes por Grado</h5>
                        <i class="fas fa-puzzle-piece"></i>
                    </div>
                    <div class="card-body">

                        <div class="selector-grado">
                            <label for="selectGrado">Seleccione un grado:</label>
                            <select id="selectGrado" class="form-control"></select>
                            <button id="btnMostrarRetos" class="btn-ver-retos">Ver Retos</button>
                        </div>

                        <div id="contenedorRetos" style="margin-top: 20px; display: none;">

                        </div>

                    </div>
                </div>
            </section>
        </div>
    </c:when>

</c:choose>

