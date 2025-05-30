package dao.admin;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.admin.Alumno;
import modelo.admin.AlumnosPorSeccion;

public class AlumnoDAO {

    public List<Alumno> obtenerAlumnos() {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT a.id_alumno, l.nombre FROM alumnos a "
                + "JOIN login l ON a.id_login = l.id "
                + "WHERE l.estado = 'activo' AND l.rol = 'alumno'";

        try (Connection conn = Conexion.getConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Alumno a = new Alumno();
                a.setIdAlumno(rs.getInt("id_alumno"));
                a.setNombre(rs.getString("nombre"));
                lista.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<AlumnosPorSeccion> obtenerConteoAlumnosPorSeccion() {
        List<AlumnosPorSeccion> lista = new ArrayList<>();

        String sql = "SELECT grado, seccion, COUNT(*) AS total_alumnos "
                + "FROM alumnos "
                + "GROUP BY grado, seccion "
                + "ORDER BY grado, seccion";

        try (Connection conn = Conexion.getConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AlumnosPorSeccion as = new AlumnosPorSeccion();
                as.setGrado(rs.getString("grado"));
                as.setSeccion(rs.getString("seccion"));
                as.setTotalAlumnos(rs.getInt("total_alumnos"));
                lista.add(as);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}
