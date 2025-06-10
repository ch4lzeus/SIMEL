package com.simel.dao_administradorJSP;

import com.simel.modelo_login.Usuario;
import com.simel.conexion.DataSourceProvider;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM login";

        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setContrasena(rs.getString("contraseña"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setFechaCreacion(rs.getString("fecha_creacion"));
                usuarios.add(usuario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarios;
    }

    public boolean insertarUsuario(Usuario usuario) {
        String sql = "INSERT INTO login (nombre, usuario, contraseña, rol, estado, fecha_creacion) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getUsuario());
            ps.setString(3, usuario.getContrasena());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editarUsuario(Usuario usuario) {
        String sql = "UPDATE login SET nombre = ?, usuario = ?, contraseña = ?, rol = ?, estado = ? WHERE id = ?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getUsuario());
            ps.setString(3, usuario.getContrasena());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());
            ps.setInt(6, usuario.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean inactivarUsuario(int id) {
        String sql = "UPDATE login SET estado = 'inactivo' WHERE id = ?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
