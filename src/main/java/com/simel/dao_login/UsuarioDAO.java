package com.simel.dao_login;

import com.simel.modelo_login.Usuario;
import com.simel.conexion.DataSourceProvider;

import java.sql.*;

public class UsuarioDAO {

    public Usuario validar(String usuario, String contrasena) {
        Usuario u = null;

        String sql = "SELECT * FROM login WHERE usuario = ? AND contraseña = ?";

        try (
            Connection conn = DataSourceProvider.getConnection(); // 🔥 Usa el pool aquí
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, usuario);
            stmt.setString(2, contrasena);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setUsuario(rs.getString("usuario"));
                u.setContrasena(rs.getString("contraseña"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                u.setFechaCreacion(rs.getString("fecha_creacion")); // si la tienes
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return u;
    }
}
