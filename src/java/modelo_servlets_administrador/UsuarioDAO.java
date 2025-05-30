package modelo_servlets_administrador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UsuarioDAO {

    // Método para editar un usuario
    public boolean editarUsuario(Usuario usuario) {
        Conexion conexion = new Conexion();
        Connection con = conexion.getConexion();
        String sql = "UPDATE login SET nombre = ?, usuario = ?, contraseña = ?, rol = ?, estado = ? WHERE id = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getUsuario());
            ps.setString(3, usuario.getContrasena());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());
            ps.setInt(6, usuario.getId()); // Usamos el ID para identificar qué usuario editar
            int resultado = ps.executeUpdate();
            return resultado > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Método para insertar un nuevo usuario
    public boolean insertarUsuario(Usuario usuario) {
        Conexion conexion = new Conexion();
        Connection con = conexion.getConexion();
        String sql = "INSERT INTO login (nombre, usuario, contraseña, rol, estado) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getUsuario());
            ps.setString(3, usuario.getContrasena());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());
            int resultado = ps.executeUpdate();
            return resultado > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// Método para inactivar un usuario (eliminación lógica)
public boolean inactivarUsuario(int id) {
    Conexion conexion = new Conexion();
    Connection con = conexion.getConexion();
    String sql = "UPDATE login SET estado = 'inactivo' WHERE id = ?"; // Cambiado a inactivo

    try {
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        int resultado = ps.executeUpdate();
        return resultado > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


}
