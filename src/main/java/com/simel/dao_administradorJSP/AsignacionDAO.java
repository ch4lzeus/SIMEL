package com.simel.dao_administradorJSP;

import com.simel.modelo_administradorJSP.Alumno;
import com.simel.modelo_administradorJSP.Curso;
import com.simel.modelo_administradorJSP.CursoAsignado;
import com.simel.modelo_administradorJSP.Docente;
import com.simel.modelo_administradorJSP.GradoSeccion;
import con.simel.conexion.DataSourceProvider;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AsignacionDAO {

    public List<Docente> obtenerDocentes() {
        List<Docente> lista = new ArrayList<>();
        String sql = "SELECT d.id, l.nombre FROM docente d JOIN login l ON d.id_login = l.id WHERE l.rol = 'docente'";

        try (Connection conn = DataSourceProvider.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Docente docente = new Docente();
                docente.setId(rs.getInt("id"));
                docente.setNombre(rs.getString("nombre"));
                lista.add(docente);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Curso> obtenerCursos() {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM curso";

        try (Connection conn = DataSourceProvider.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Curso curso = new Curso();
                curso.setId(rs.getInt("id"));
                curso.setNombre(rs.getString("nombre"));
                lista.add(curso);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<GradoSeccion> obtenerGradosSecciones() {
        List<GradoSeccion> lista = new ArrayList<>();
        String sql = "SELECT * FROM grado_seccion";

        try (Connection conn = DataSourceProvider.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                GradoSeccion gs = new GradoSeccion();
                gs.setId(rs.getInt("id"));
                gs.setGrado(rs.getInt("grado"));
                gs.setSeccion(rs.getString("seccion"));
                lista.add(gs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<CursoAsignado> obtenerCursosAsignados() {
        List<CursoAsignado> lista = new ArrayList<>();
        String sql = "SELECT d.nombre AS docente_nombre, c.nombre AS curso_nombre, gs.grado, gs.seccion "
                + "FROM curso_grado_docente cgd "
                + "JOIN docente d ON cgd.id_docente = d.id "
                + "JOIN curso c ON cgd.id_curso = c.id "
                + "JOIN grado_seccion gs ON cgd.id_grado_seccion = gs.id";

        try (Connection conn = DataSourceProvider.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CursoAsignado asignado = new CursoAsignado();
                asignado.setDocenteNombre(rs.getString("docente_nombre"));
                asignado.setCursoNombre(rs.getString("curso_nombre"));
                asignado.setGrado(rs.getInt("grado"));
                asignado.setSeccion(rs.getString("seccion"));
                lista.add(asignado);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Alumno> obtenerAlumnos() {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT a.id, l.nombre FROM alumno a JOIN login l ON a.id_login = l.id WHERE l.rol = 'alumno'";

        try (Connection conn = DataSourceProvider.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Alumno alumno = new Alumno();
                alumno.setId(rs.getInt("id"));
                alumno.setNombre(rs.getString("nombre"));
                lista.add(alumno);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<String> obtenerResumenAlumnosPorSeccion() {
        List<String> lista = new ArrayList<>();
        String sql = "SELECT gs.grado, gs.seccion, COUNT(*) AS total "
                + "FROM alumno a "
                + "JOIN grado_seccion gs ON a.id_grado_seccion = gs.id "
                + "GROUP BY gs.grado, gs.seccion "
                + "ORDER BY gs.grado, gs.seccion";

        try (Connection conn = DataSourceProvider.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int grado = rs.getInt("grado");
                String seccion = rs.getString("seccion");
                int total = rs.getInt("total");

                String resumen = "Sección: <strong>" + grado + "° - " + seccion + "</strong> - Total alumnos: <strong>" + total + "</strong>";
                lista.add(resumen);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

}