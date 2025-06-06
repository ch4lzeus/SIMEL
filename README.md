# SIMEL

Sistema de Incentivo y Motivación para Estudiantes de Lima.

## Tecnologías utilizadas

- Java
- NetBeans
- JSP, Servlets
- Bootstrap 4
- MySQL
- Arquitectura MVC (Modelo 2)
- Maven

## Descripción

Sistema web con cuatro módulos principales:
- Login de usuarios
- Panel de administrador
- Panel de docente
- Panel de alumno

El proyecto aplica el patrón Modelo-Vista-Controlador (MVC) e incluye:
- JSP, CSS y JavaScript para el frontend
- Clases modelo para representar entidades
- DAOs por rol para el acceso a base de datos
- Servlets como controladores por rol

Actualmente en desarrollo. El frontend está implementado; faltan integrar consultas dinámicas por rol. Se utilizan datos estáticos de forma temporal.

## Estructura principal

- `src/` — Código fuente (modelo, DAO, servlets, vistas)
- `pom.xml` — Configuración del proyecto Maven
- `.mvn/`, `mvnw`, `mvnw.cmd` — Maven Wrapper
- `.gitignore` — Exclusión de carpetas generadas

## Requisitos

- JDK 17 (o versión compatible)
- NetBeans 12+ o cualquier IDE con soporte Maven
- MySQL

## Ejecución del proyecto

```bash
git clone https://github.com/tu-usuario/SIMEL.git
cd SIMEL
./mvnw clean install
