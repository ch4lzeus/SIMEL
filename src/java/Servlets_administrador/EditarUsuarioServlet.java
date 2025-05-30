//Servlet para editar o actulizar un usuario.
package Servlets_administrador;
import modelo_servlets_administrador.Usuario;
import modelo_servlets_administrador.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/editarUsuario")
public class EditarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Obtener los parámetros de la solicitud
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String cargo = request.getParameter("cargo");
        String estado = request.getParameter("estado");

        // Crear el objeto Usuario con los datos proporcionados
        Usuario usuarioEditar = new Usuario(nombre, usuario, password, cargo, estado);
        usuarioEditar.setId(id); // Setear el ID para identificar el usuario a editar

        // Usar la clase UsuarioDAO para actualizar el usuario en la base de datos
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean resultado = usuarioDAO.editarUsuario(usuarioEditar);

        // Enviar una respuesta al frontend
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (resultado) {
            out.print("OK");
        } else {
            out.print("ERROR");
        }
    }
}

