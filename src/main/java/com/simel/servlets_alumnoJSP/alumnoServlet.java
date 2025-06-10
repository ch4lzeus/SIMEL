package com.simel.servlets_alumnoJSP;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import Servlets_administrador.Usuario;
@WebServlet("/alumno")
public class alumnoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String seccion = request.getParameter("seccion");
        if (seccion == null || seccion.isEmpty()) {
            seccion = "misCursos";  // valor por defecto
        }
 
        switch (seccion) {
            case "misCursos":

                break;
            
            case "misNotas":

                break;
           
            case "logros":
                break;
          
            case "canjes":
                break;
            
            case "retos":
                break;
            default:
                break;
        }

        // Resto de las secciones igual...
        request.setAttribute("seccion", seccion);
        request.getRequestDispatcher("/alumno.jsp").forward(request, response);
    }
}
