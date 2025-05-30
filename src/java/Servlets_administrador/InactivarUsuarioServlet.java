package Servlets_administrador;

import modelo_servlets_administrador.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/inactivarUsuario")
public class InactivarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean resultado = usuarioDAO.inactivarUsuario(id); // Cambiado a inactivar

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (resultado) {
            out.print("OK");
        } else {
            out.print("ERROR");
        }
    }
}

