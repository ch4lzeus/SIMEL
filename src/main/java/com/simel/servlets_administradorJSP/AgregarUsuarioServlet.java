package com.simel.servlets_administradorJSP;

import com.simel.dao_administradorJSP.UsuarioDAO;
import com.simel.modelo_login.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/agregarUsuario")
public class AgregarUsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String rol = request.getParameter("cargo");
        String estado = request.getParameter("estado");

        // Crear objeto Usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setUsuario(usuario);
        nuevoUsuario.setContrasena(password);
        nuevoUsuario.setRol(rol);
        nuevoUsuario.setEstado(estado);

        // Insertar usuario con DAO
        boolean resultado = usuarioDAO.insertarUsuario(nuevoUsuario);

        // Enviar respuesta al frontend
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(resultado ? "OK" : "ERROR");
    }
}
