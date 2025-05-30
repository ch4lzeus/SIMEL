//Servlet para agregar un nuevo usuario a la tabla Login.
package Servlets_administrador;
import modelo_servlets_administrador.Conexion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/agregarUsuario")
public class AgregarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String cargo = request.getParameter("cargo");
        String estado = request.getParameter("estado");

        Conexion conexion = new Conexion();
        Connection con = conexion.getConexion();

        String sql = "INSERT INTO login (nombre, usuario, contraseña, rol, estado) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, usuario);
            ps.setString(3, password);
            ps.setString(4, cargo);
            ps.setString(5, estado);
            int filas = ps.executeUpdate();

            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            if (filas > 0) {
                out.print("OK");
            } else {
                out.print("ERROR");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("ERROR");
        }
    }
}