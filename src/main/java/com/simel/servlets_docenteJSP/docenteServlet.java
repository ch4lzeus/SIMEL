package com.simel.servlets_docenteJSP;

//import Servlets_administrador.Usuario;
import com.simel.dao_docenteJSP.DocenteDAO;
import com.simel.modelo_docenteJSP.CursoAsignadoDocente;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

//import Servlets_administrador.Usuario;
@WebServlet("/docente")
public class docenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String seccion = request.getParameter("seccion");
        if (seccion == null || seccion.isEmpty()) {
            seccion = "misCursos";  // valor por defecto
        }

        HttpSession session = request.getSession();
        String usuarioSesion = (String) session.getAttribute("usuario"); // usuario de login
        int idDocente = new DocenteDAO().obtenerIdDocentePorUsuario(usuarioSesion);

        // Puedes guardar el ID en sesión si lo vas a usar varias veces
        session.setAttribute("idDocente", idDocente);
        switch (seccion) {
            case "misCursos":
                List<CursoAsignadoDocente> cursos = new DocenteDAO().obtenerCursosPorDocente(idDocente);
                request.setAttribute("cursosAsignados", cursos);
                break;
            // Sección 3: Logros
            case "ingresarNotas":

                break;
            // Sección 4: Canjes
            case "asignarLogros":
                break;
            // Sección 5: Reportes
            case "rankingEstudiantes":
                break;
            // Sección 6: Configuración
            case "retosEstudiantes":
                break;
            default:
                break;
        }

        // Resto de las secciones igual...
        request.setAttribute("seccion", seccion);
        request.getRequestDispatcher("/docente.jsp").forward(request, response);
    }
}

