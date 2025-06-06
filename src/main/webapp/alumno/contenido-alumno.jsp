<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String seccion = request.getParameter("seccion");
    if (seccion == null || seccion.isEmpty()) {
        seccion = "misCursos"; // Mostrar sección por defecto
    }
%>



<!------------------------------------------------------------ Seccion 1 --------------------------------------------------------------------------------------->
<% if ("misCursos".equals(seccion)) { %>
<div class="container mt-5">
    <section class="panel-alumno panel-cursos animate__animated animate__fadeIn">
        <div class="card shadow-sm">
            <div class="card-header bg-alumno text-primary d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Mis asignaturas actuales</h5>
                <i class="fas fa-book-reader"></i>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered text-center align-middle tabla-cursos">
                        <thead class="encabezado-primaria">
                            <tr>
                                <th>Código</th>
                                <th>Nombre del Curso</th>
                                <th>Docente</th>
                                <th>Grado</th>
                                <th>Sección</th>
                                <th>Estado</th>
                            </tr>
                        </thead>    
                        <tbody class="text-center">
                            <tr>
                                <td>C001</td>
                                <td>
                                    <a href="#" onclick="verDetalleCurso('Matemática')" class="link-curso">Matemática</a>
                                </td>
                                <td>Juan Pérez</td>
                                <td>4°</td>
                                <td>A</td>
                                <td><span class="estado-curso activo">🟢 Activo</span></td>
                            </tr>
                            <tr>
                                <td>C002</td>
                                <td>
                                    <a href="#" onclick="verDetalleCurso('Historia')" class="link-curso">Historia</a>
                                </td>
                                <td>María Velázquez</td>
                                <td>5°</td>
                                <td>A</td>
                                <td><span class="estado-curso finalizado">🔴 Finalizado</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</div>

<!------------------------------------------------------------ Seccion 2 --------------------------------------------------------------------------------------->
<% } else if ("misNotas".equals(seccion)) { %>
<div class="container mt-5">
    <section class="panel-notas animate__animated animate__fadeIn">
        <!-- 🟦 Encabezado -->
        <div class="card shadow-sm">
            <div class="card-header bg-alumno text-primary d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Mis notas académicas</h5>
                <i class="fas fa-file-alt"></i>
            </div>

            <div class="card-body">
                <!-- 🔽 Selector de curso -->
                <div class="mb-4">
                    <label for="selectCursoNota" class="form-label fw-semibold">Selecciona un curso:</label>
                    <!-- Select personalizado solo para notas -->
                    <select id="selectCursoNota" class="form-select select-notas-curso">
                        <option selected disabled>Elige un curso</option>
                        <option value="matematica">Matemática</option>
                        <option value="historia">Historia</option>
                        <option value="ciencia">Ciencia y Tecnología</option>
                    </select>

                </div>

                <!-- ⬇️ Contenido de notas (oculto hasta elegir curso) -->
                <div id="contenidoNotas" style="display: none;">
                    <!-- Tabla de notas -->
                    <div class="table-responsive">
                        <table class="table table-bordered text-center align-middle tabla-notas">
                            <thead class="encabezado-notas">
                                <tr>
                                    <th>Evaluación</th>
                                    <th>Nota</th>
                                    <th>Comentario</th>
                                </tr>
                            </thead>
                            <tbody class="text-center" id="tablaNotas">
                                <!-- Se llena dinámicamente -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Promedio -->
                    <div class="promedio-general mt-4 text-center">
                        <h4>Promedio General: <span id="promedio">--</span></h4>
                    </div>

                    <!-- Gráfico -->
                    <div class="grafico-evolucion mt-5">
                        <canvas id="graficoNotas"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>







<!------------------------------------------------------------ Seccion 3 --------------------------------------------------------------------------------------->
<% } else if ("logros".equals(seccion)) { %>
<div class="container mt-5">
    <section class="panel-logros animate__animated animate__fadeIn">
        <div class="card shadow-sm">
            <div class="card-header bg-alumno text-primary d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Mis logros y nivel</h5>
                <i class="fas fa-trophy me-2"></i>
            </div>
            <div class="card-body">
                <!-- Aquí va tu contenido de nivel y logros -->
                <div class="nivel-logros text-center mb-4">
                    <h4 class="fw-bold">Nivel 3: Avanzado</h4>
                    <div class="progress custom-progress" style="height: 20px;">
                        <div class="progress-bar bg-primary" style="width: 65%;" role="progressbar" aria-valuenow="65"
                             aria-valuemin="0" aria-valuemax="100">130 / 200 pts
                        </div>
                    </div>
                </div>

                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <!-- tarjetas de logros -->
                    <div class="col">
                        <div class="card logro-card shadow-sm h-100">
                            <div class="card-body">
                                <h5 class="card-title">🥇 Superación Personal</h5>
                                <p class="card-text"><strong>Curso:</strong> Matemática</p>
                                <p class="card-text"><strong>Fecha:</strong> 01/05/2025</p>
                                <p class="card-text text-primary"><strong>+10 puntos</strong></p>
                            </div>                
                        </div>
                    </div>

                    <div class="col">
                        <div class="card logro-card shadow-sm h-100">
                            <div class="card-body">
                                <h5 class="card-title">🎯 Asistencia Perfecta</h5>
                                <p class="card-text"><strong>Curso:</strong> Historia</p>
                                <p class="card-text"><strong>Fecha:</strong> 15/04/2025</p>
                                <p class="card-text text-primary"><strong>+5 puntos</strong></p>
                            </div>
                        </div>
                    </div>

                    <!-- Nueva tarjeta agregada -->
                    <div class="col">
                        <div class="card logro-card shadow-sm h-100">
                            <div class="card-body">
                                <h5 class="card-title">📚 Proyecto Destacado</h5>
                                <p class="card-text"><strong>Curso:</strong> Ciencia y Tecnología</p>
                                <p class="card-text"><strong>Fecha:</strong> 20/05/2025</p>
                                <p class="card-text text-primary"><strong>+15 puntos</strong></p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</div>





<!------------------------------------------------------------ Seccion 4 --------------------------------------------------------------------------------------->
<% } else if ("canjes".equals(seccion)) { %>
<div class="container mt-5">
  <section class="panel-canjes animate__animated animate__fadeIn">
    <div class="card shadow-sm">
      <!-- Encabezado con estilo e icono -->
      <div class="card-header bg-alumno text-primary d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Mis premios y canjes</h5>
        <i class="fas fa-gift"></i>
      </div>

      <div class="card-body">
        <!-- Filtro por puntos -->
        <div class="filtros-canjes d-flex justify-content-end mb-4">
          <select id="filtroPuntos" class="form-select select-canjes-filtro w-auto">
            <option value="todos">Todos los premios</option>
            <option value="disponibles">Premios que puedo canjear</option>
          </select>
        </div>

        <!-- Catálogo de premios -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4" id="catalogoPremios">
          <!-- Premio físico -->
          <div class="col">
            <div class="card premio-card h-100 shadow-sm">
              <img src="https://images.unsplash.com/photo-1563213126-e4d6c33b4324?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Bolígrafo Escolar">
              <div class="card-body">
                <h5 class="card-title text-dark">Bolígrafo Escolar</h5>
                <p class="card-text">Bolígrafo con el logo del colegio.</p>
                <p class="puntos-requeridos text-primary"><strong>10 puntos</strong></p>
                <button class="btn btn-primary w-100" onclick="canjearPremio('Bolígrafo Escolar', 10, 'físico')">Canjear</button>
              </div>
            </div>
          </div>

          <!-- Premio digital -->
          <div class="col">
            <div class="card premio-card h-100 shadow-sm">
              <img src="img/canjes_CursoOnline.svg" class="card-img-top" alt="Curso Online">
              <div class="card-body">
                <h5 class="card-title text-dark">Curso Online</h5>
                <p class="card-text">Acceso a curso digital exclusivo.</p>
                <p class="puntos-requeridos text-primary"><strong>15 puntos</strong></p>
                <button class="btn btn-primary w-100" onclick="canjearPremio('Curso Online', 15, 'digital')">Canjear</button>
              </div>
            </div>
          </div>

          <!-- Premio físico -->
          <div class="col">
            <div class="card premio-card h-100 shadow-sm">
              <img src="https://images.unsplash.com/photo-1550592704-6c76def9b9f5?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Cuaderno Especial">
              <div class="card-body">
                <h5 class="card-title text-dark">Cuaderno Especial</h5>
                <p class="card-text">Cuaderno con diseño personalizado.</p>
                <p class="puntos-requeridos text-primary"><strong>20 puntos</strong></p>
                <button class="btn btn-primary x    w-100" onclick="canjearPremio('Cuaderno Especial', 20, 'físico')">Canjear</button>
              </div>
            </div>
          </div>

          <!-- Puedes agregar más premios aquí -->
        </div>

        <!-- Sección de Canjes Realizados -->
        <h5 class="mt-5 fw-semibold">📝 Canjes realizados</h5>
        <div id="canjesRealizados" class="list-group">
          <!-- Aquí se agregarán dinámicamente los canjes realizados -->
        </div>
      </div>
    </div>
  </section>
</div>







<!------------------------------------------------------------ Seccion 5 --------------------------------------------------------------------------------------->
<% } else if ("retos".equals(seccion)) { %>
<div class="container mt-5">
  <section class="panel-retosalumno animate__animated animate__fadeIn">
    <div class="card shadow-sm">
      <div class="card-header bg-alumno text-primary d-flex justify-content-between align-items-center">
        <h5 class="mb-0 fw-bold">Mis Retos</h5>
        <i class="fas fa-flag-checkered"></i>
      </div>
      <div class="card-body">
        <!-- Navegación de pestañas -->
        <ul class="nav nav-tabs" id="retosTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="activos-tab" data-bs-toggle="tab" data-bs-target="#activos" type="button" role="tab">Retos Activos</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="completados-tab" data-bs-toggle="tab" data-bs-target="#completados" type="button" role="tab">Completados</button>
          </li>
        </ul>

        <!-- Contenido de pestañas -->
        <div class="tab-content mt-4">
          <!-- Retos Activos -->
          <div class="tab-pane fade show active" id="activos" role="tabpanel">
            <div class="row row-cols-1 row-cols-md-2 g-4">
              <div class="col">
                <div class="card reto-card shadow-sm h-100">
                  <div class="card-body">
                    <h5 class="card-title">📘 Tareas Sin Errores</h5>
                    <p class="card-text">Realiza 3 tareas seguidas sin errores.</p>
                    <p class="text-muted">Fecha límite: <strong>30/05/2025</strong></p>
                    <p class="text-warning">🎯 Puntos: <strong>10</strong></p>
                  </div>
                </div>
              </div>

              <div class="col">
                <div class="card reto-card shadow-sm h-100">
                  <div class="card-body">
                    <h5 class="card-title">📗 Participación Destacada</h5>
                    <p class="card-text">Participa en todas las clases de la semana.</p>
                    <p class="text-muted">Fecha límite: <strong>25/05/2025</strong></p>
                    <p class="text-warning">🎯 Puntos: <strong>15</strong></p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Retos Completados -->
          <div class="tab-pane fade" id="completados" role="tabpanel">
            <div class="row row-cols-1 row-cols-md-2 g-4">
              <div class="col">
                <div class="card reto-card shadow-sm h-100 border border-2 border-success">
                  <div class="card-body position-relative">
                    <span class="badge bg-success position-absolute top-0 end-0 m-2">✔ Completado</span>
                    <h5 class="card-title mt-4">📒 Entrega Puntual</h5>
                    <p class="card-text">Entregaste todas las tareas a tiempo durante 2 semanas.</p>
                    <p class="text-muted">Completado el: <strong>10/05/2025</strong></p>
                    <p class="text-warning">🎯 Puntos ganados: <strong>12</strong></p>
                  </div>
                </div>
              </div>

              <!-- Más retos completados... -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<% }%>
