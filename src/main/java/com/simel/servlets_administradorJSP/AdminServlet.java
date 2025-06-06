package com.simel.servlets_administradorJSP;

import com.simel.dao_administradorJSP.AsignacionDAO;
import com.simel.dao_administradorJSP.UsuarioDAO;
import com.simel.modelo_administradorJSP.Alumno;
import com.simel.modelo_administradorJSP.Curso;
import com.simel.modelo_administradorJSP.CursoAsignado;
import com.simel.modelo_administradorJSP.Docente;
import com.simel.modelo_administradorJSP.GradoSeccion;
import com.simel.modelo_login.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/administrador")
public class AdminServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();  // Ya no usa la clase Conexion

    private final AsignacionDAO asignacionDAO = new AsignacionDAO();  // nuevo DAO que contiene los métodos
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String seccion = request.getParameter("seccion");
        if (seccion == null || seccion.isEmpty()) {
            seccion = "usuarios";  // valor por defecto
        }

        switch (seccion) {
            case "usuarios":
                List<Usuario> listaUsuarios = usuarioDAO.obtenerUsuarios();
                request.setAttribute("usuarios", listaUsuarios);
                break;

            // Sección 3: Logros
            case "cursosAsignaciones":
                List<Docente> docentes = asignacionDAO.obtenerDocentes();
                List<Curso> cursos = asignacionDAO.obtenerCursos();
                List<GradoSeccion> gradosSeccion = asignacionDAO.obtenerGradosSecciones();
                List<CursoAsignado> cursosAsignados = asignacionDAO.obtenerCursosAsignados();
                List<Alumno> alumnos = asignacionDAO.obtenerAlumnos();
                List<String> resumenPorSeccion = asignacionDAO.obtenerResumenAlumnosPorSeccion();
                request.setAttribute("docentes", docentes);
                request.setAttribute("cursos", cursos);
                request.setAttribute("gradosSeccion", gradosSeccion);
                request.setAttribute("cursosAsignados", cursosAsignados);
                request.setAttribute("alumnos", alumnos);
                request.setAttribute("resumenPorSeccion", resumenPorSeccion);
                break;
            // Sección 4: Canjes
            case "logrosPremios":
                break;
            // Sección 5: Reportes
            case "canjes":
                break;
            // Sección 6: Configuración
            case "reportes":
                break;
            case "retosadmin":
                break;
            default:
                break;
        }

        // Resto de las secciones igual...
        request.setAttribute("seccion", seccion);
        request.getRequestDispatcher("/administrador.jsp").forward(request, response);
    }
}
