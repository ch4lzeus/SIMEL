package com.simel.dao_docenteJSP;

import com.simel.modelo_administradorJSP.Alumno;
import java.sql.*;
import com.simel.modelo_docenteJSP.CursoAsignadoDocente;
import java.util.ArrayList;
import java.util.List;

public class DocenteDAO {

    private final String jdbcURL = "jdbc:mysql://localhost:3306/simel?serverTimezone=America/Lima";
    private final String jdbcUser = "root";
    private final String jdbcPassword = "chalan123";

    public int obtenerIdDocentePorUsuario(String nombreUsuario) {
        int idDocente = -1;

        String sql = "SELECT d.id "
                + "FROM docente d "
                + "JOIN login l ON d.id_login = l.id "
                + "WHERE l.usuario = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nombreUsuario);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                idDocente = rs.getInt("id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return idDocente;
    }

    public List<CursoAsignadoDocente> obtenerCursosPorDocente(int idDocente) {
        List<CursoAsignadoDocente> cursos = new ArrayList<>();

        String sql = "SELECT c.id AS id_curso, c.nombre AS nombre_curso, gs.grado, gs.seccion, "
                + "       (SELECT COUNT(*) FROM alumno a WHERE a.id_grado_seccion = gs.id) AS total_alumnos "
                + "FROM curso_grado_docente cgd "
                + "JOIN curso c ON cgd.id_curso = c.id "
                + "JOIN grado_seccion gs ON cgd.id_grado_seccion = gs.id "
                + "WHERE cgd.id_docente = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idDocente);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CursoAsignadoDocente curso = new CursoAsignadoDocente(
                        rs.getInt("id_curso"),
                        rs.getString("nombre_curso"),
                        rs.getInt("grado"),
                        rs.getString("seccion"),
                        rs.getInt("total_alumnos")
                );
                cursos.add(curso);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cursos;
    }

    public List<Alumno> obtenerAlumnosPorCursoGradoSeccion(int idCurso, int grado, String seccion) {
        List<Alumno> alumnos = new ArrayList<>();

        String sql = "SELECT a.id, a.nombre "
                + "FROM alumno a "
                + "JOIN grado_seccion gs ON a.id_grado_seccion = gs.id "
                + "JOIN curso_grado_docente cgd ON cgd.id_grado_seccion = gs.id "
                + "WHERE cgd.id_curso = ? AND gs.grado = ? AND gs.seccion = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idCurso);
            stmt.setInt(2, grado);
            stmt.setString(3, seccion);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Alumno alumno = new Alumno();
                alumno.setId(rs.getInt("id"));
                alumno.setNombre(rs.getString("nombre"));
                alumnos.add(alumno);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return alumnos;
    }
    

}
