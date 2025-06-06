package com.simel.servlets_administradorJSP;

import com.simel.dao_administradorJSP.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/inactivarUsuario")
public class InactivarUsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));

        boolean resultado = usuarioDAO.inactivarUsuario(id);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(resultado ? "OK" : "ERROR");
    }
}
