package dao.admin;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.admin.AsignacionCurso;
import modelo.admin.Curso;
import modelo.admin.Docente;

public class CursoDAO {

    public List<Docente> obtenerDocentes() {
        List<Docente> lista = new ArrayList<>();
        String sql = "SELECT d.id_docente, l.nombre FROM docentes d JOIN login l ON d.id_login = l.id WHERE l.estado = 'activo' AND l.rol = 'docente'";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Docente d = new Docente();
                d.setIdDocente(rs.getInt("id_docente"));
                d.setNombre(rs.getString("nombre"));
                lista.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

public List<Curso> obtenerCursos() {
    List<Curso> cursos = new ArrayList<>();
    String sql = "SELECT id_curso, nombre FROM cursos";

    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Curso curso = new Curso();
            curso.setId(rs.getInt("id_curso"));
            curso.setNombre(rs.getString("nombre"));
            cursos.add(curso);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return cursos;
}


public List<AsignacionCurso> obtenerCursosAsignados() {
    List<AsignacionCurso> lista = new ArrayList<>();
    String sql = "SELECT c.nombre AS nombre_curso, l.nombre AS nombre_docente "
               + "FROM cursos_docentes cd "
               + "JOIN cursos c ON cd.id_curso = c.id_curso "
               + "JOIN docentes d ON cd.id_docente = d.id_docente "
               + "JOIN login l ON d.id_login = l.id";

    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            AsignacionCurso ac = new AsignacionCurso();
            ac.setNombreCurso(rs.getString("nombre_curso"));
            ac.setNombreDocente(rs.getString("nombre_docente"));
            lista.add(ac);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return lista;
}



    // Aquí puedes agregar los demás métodos como obtenerCursos(), asignarCursosADocente(), etc.
}
