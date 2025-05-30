// Servlet para hacer la validación en index.jsp
package servlets_login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/sistema?serverTimezone=America/Lima&useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chalan123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Establecer la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PrintWriter out = response.getWriter();

        try {
            // Conexión a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM login WHERE usuario = ? AND contraseña = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, usuario);
            stmt.setString(2, password);

            rs = stmt.executeQuery();

            if (rs.next()) {
                String estado = rs.getString("estado"); // Obtener el estado del usuario

                if ("inactivo".equals(estado)) {
                    // Si el usuario está inactivo, enviamos un mensaje de error
                    out.write("{\"status\":\"inactive\", \"message\":\"Usuario inactivo\"}");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    String rol = rs.getString("rol");
                    session.setAttribute("rol", rol);
                    String nombre = rs.getString("nombre"); // Obtener nombre completo
                    session.setAttribute("nombre", nombre); // Guardarlo en sesión

                    // Declarar la variable fuera del switch
                    String redirectPage = "";

                    switch (rol) {
                        case "administrador":
                            session.setAttribute("panelOrigen", "administrador");
                            redirectPage = "administrador";
                            break;
                        case "docente":
                            session.setAttribute("panelOrigen", "docente.jsp");
                            redirectPage = "docente.jsp";
                            break;
                        case "alumno":
                            session.setAttribute("panelOrigen", "alumno.jsp");
                            redirectPage = "alumno.jsp";
                            break;
                        default:
                            redirectPage = "index.jsp";
                            break;
                    }

                    // Enviar respuesta JSON
                    out.write("{\"status\":\"success\", \"redirectPage\":\"" + redirectPage + "\"}");
                }
            } else {
                out.write("{\"status\":\"error\", \"message\":\"Usuario y/o contraseña incorrecta\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"status\":\"error\", \"message\":\"Error en la conexión con la base de datos.\"}");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }
}
