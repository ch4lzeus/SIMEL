package com.simel.servlets_administradorJSP;

import com.simel.dao_administradorJSP.UsuarioDAO;
import com.simel.modelo_login.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/editarUsuario")
public class EditarUsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Obtener datos del formulario
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String rol = request.getParameter("cargo");
        String estado = request.getParameter("estado");

        // Crear objeto usuario con los datos recibidos
        Usuario usuarioEditar = new Usuario();
        usuarioEditar.setId(id);
        usuarioEditar.setNombre(nombre);
        usuarioEditar.setUsuario(usuario);
        usuarioEditar.setContrasena(password);
        usuarioEditar.setRol(rol);
        usuarioEditar.setEstado(estado);

        // Editar usuario mediante DAO
        boolean resultado = usuarioDAO.editarUsuario(usuarioEditar);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(resultado ? "OK" : "ERROR");
    }
}
