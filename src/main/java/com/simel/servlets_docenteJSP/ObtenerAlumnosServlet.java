package com.simel.servlets_docenteJSP;

import com.simel.dao_docenteJSP.DocenteDAO;
import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/obtenerAlumnos")
public class ObtenerAlumnosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idCurso = Integer.parseInt(request.getParameter("idCurso"));
        int grado = Integer.parseInt(request.getParameter("grado"));
        String seccion = request.getParameter("seccion");

        DocenteDAO dao = new DocenteDAO();
        List<com.simel.modelo_administradorJSP.Alumno> alumnos = dao.obtenerAlumnosPorCursoGradoSeccion(idCurso, grado, seccion);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = new Gson().toJson(alumnos);
        response.getWriter().write(json);
    }
}
