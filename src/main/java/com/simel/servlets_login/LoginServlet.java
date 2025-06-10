package com.simel.servlets_login;

import com.simel.dao_login.UsuarioDAO;
import com.simel.modelo_login.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();

        // Usar el DAO para validar credenciales
        UsuarioDAO dao = new UsuarioDAO();
        Usuario user = dao.validar(usuario, password);

        if (user != null) {
            if ("inactivo".equalsIgnoreCase(user.getEstado())) {
                out.write("{\"status\":\"inactive\", \"message\":\"Usuario inactivo\"}");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("usuario", user.getUsuario());
            session.setAttribute("rol", user.getRol());
            session.setAttribute("nombre", user.getNombre());
            session.setAttribute("id_login", user.getId());

            // Asignar imagen según el rol
            String imgSrc = "img/admin.svg"; // default
            switch (user.getRol()) {
                case "alumno":
                    imgSrc = "img/student.svg";
                    break;
                case "docente":
                    imgSrc = "img/teacher.svg";
                    break;
                case "administrador":
                    imgSrc = "img/admin.svg";
                    break;
            }
            session.setAttribute("imgSrc", imgSrc);

            // Redirección según el rol
            String redirectPage = "index.jsp"; // valor por defecto
            switch (user.getRol()) {
                case "administrador":
                    session.setAttribute("panelOrigen", "administrador");
                    redirectPage = "administrador";
                    break;
                case "docente":
                    session.setAttribute("panelOrigen", "docente");
                    redirectPage = "docente";
                    break;
                case "alumno":
                    session.setAttribute("panelOrigen", "alumno");
                    redirectPage = "alumno";
                    break;
            }

            out.write("{\"status\":\"success\", \"redirectPage\":\"" + redirectPage + "\"}");

        } else {
            out.write("{\"status\":\"error\", \"message\":\"Usuario y/o contraseña incorrecta\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet con uso de DAO y pool de conexiones";
    }
}
