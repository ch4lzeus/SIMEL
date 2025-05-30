package Servlets_administrador;

import dao.admin.CursoDAO;
import modelo.admin.Curso;
import modelo.admin.Docente;
import Servlets_administrador.Usuario;
import dao.admin.AlumnoDAO;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import modelo.admin.Alumno;
import modelo.admin.AlumnosPorSeccion;
import modelo.admin.AsignacionCurso;

@WebServlet("/administrador")
public class AdminServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/sistema?serverTimezone=America/Lima&useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chalan123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String seccion = request.getParameter("seccion");
        if (seccion == null || seccion.isEmpty()) {
            seccion = "usuarios";  // valor por defecto para que cargue usuarios al entrar
        }
        
        // Sección 1: Usuarios
        if ("usuarios".equals(seccion)) {
            List<Usuario> listaUsuarios = new ArrayList<>();

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = "SELECT * FROM login";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setUsuario(rs.getString("usuario"));
                    usuario.setContrasena(rs.getString("Contraseña"));
                    usuario.setRol(rs.getString("rol"));
                    usuario.setEstado(rs.getString("estado"));
                    usuario.setFechaCreacion(rs.getString("Fecha_creacion"));
                    listaUsuarios.add(usuario);
                }

                rs.close();
                stmt.close();
                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

            request.setAttribute("usuarios", listaUsuarios);
            
            
            // Sección 2: Cursos y asignaciones
        } else if ("cursosAsignaciones".equals(seccion)) {
            CursoDAO dao = new CursoDAO();
            AlumnoDAO al = new AlumnoDAO();

            List<Docente> docentes = dao.obtenerDocentes();
            List<Curso> cursos = dao.obtenerCursos();
            List<AsignacionCurso> asignaciones = dao.obtenerCursosAsignados();
            List<Alumno> alumnos = al.obtenerAlumnos();
            List<AlumnosPorSeccion> conteoPorSeccion = al.obtenerConteoAlumnosPorSeccion();

            request.setAttribute("docentes", docentes);
            request.setAttribute("cursos", cursos);
            request.setAttribute("cursosAsignados", asignaciones);
            request.setAttribute("alumnos", alumnos);
            // En tu servlet:
            request.setAttribute("alumnosPorSeccion", conteoPorSeccion);

        }
        
        // Sección 3: Logros
        else if ("logrosPremios".equals(seccion)){
                
            }
        
        
                // Sección 4: Canjes
        else if ("canjes".equals(seccion)) {
            // Aquí cargarás los canjes hechos por alumnos.
            // Ejemplo futuro:
            // List<Canje> canjes = canjeDAO.obtenerCanjes();
            // request.setAttribute("canjes", canjes);
        }

        // Sección 5: Reportes
        else if ("reportes".equals(seccion)) {
            // Aquí podrías preparar estadísticas generales, como reportes de cursos, asistencia, etc.
            // Ejemplo futuro:
            // List<Reporte> reportes = reporteDAO.obtenerReportes();
            // request.setAttribute("reportes", reportes);
        }

        // Sección 6: Configuración
        else if ("retosadmin".equals(seccion)) {
            // Aquí puedes mostrar o editar configuración como el año académico, fechas, etc.
            // Ejemplo futuro:
            // ConfiguracionSistema config = configDAO.obtenerConfiguracionActual();
            // request.setAttribute("configuracion", config);
        }


        // Poner el atributo para que JSP sepa qué sección mostrar
        request.setAttribute("seccion", seccion);

        // Forward al JSP que incluye la sección correspondiente
        request.getRequestDispatcher("/administrador.jsp").forward(request, response);
    }

}
