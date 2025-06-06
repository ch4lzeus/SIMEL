package com.simel.modelo_docenteJSP;

public class CursoAsignadoDocente {
    private int idCurso;
    private String nombreCurso;
    private int grado;
    private String seccion;
    private int totalAlumnos;

    // Constructor vacío
    public CursoAsignadoDocente() {}

    // Constructor completo
    public CursoAsignadoDocente(int idCurso, String nombreCurso, int grado, String seccion, int totalAlumnos) {
        this.idCurso = idCurso;
        this.nombreCurso = nombreCurso;
        this.grado = grado;
        this.seccion = seccion;
        this.totalAlumnos = totalAlumnos;
    }

    // Getters y setters
    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getNombreCurso() { return nombreCurso; }
    public void setNombreCurso(String nombreCurso) { this.nombreCurso = nombreCurso; }

    public int getGrado() { return grado; }
    public void setGrado(int grado) { this.grado = grado; }

    public String getSeccion() { return seccion; }
    public void setSeccion(String seccion) { this.seccion = seccion; }

    public int getTotalAlumnos() { return totalAlumnos; }
    public void setTotalAlumnos(int totalAlumnos) { this.totalAlumnos = totalAlumnos; }
}
