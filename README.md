# SIMEL - Sistema de Incentivo y Motivación para Estudiantes de Lima

SIMEL es una plataforma web académica desarrollada como proyecto universitario. Su objetivo principal es **motivar el rendimiento académico de los estudiantes** mediante retos, logros y un sistema de canje de premios. Está implementado usando Java, JSP y Servlets, con conexión a una base de datos MySQL.

---

## 🎯 Objetivo

Fomentar la participación activa y el desempeño académico de los estudiantes a través de un sistema de incentivos basado en puntos, retos y logros.

---

## 🧑‍💻 Roles del sistema

### 🧑 Alumno
- Visualiza sus **notas**, **calificaciones**, y **logros obtenidos**
- Consulta sus **puntos acumulados**
- Participa en **retos académicos**
- Canjea premios (digitales o físicos) con un código generado

### 👨‍🏫 Docente
- **Sube notas** de los alumnos por curso
- **Asigna logros** a alumnos destacados
- Revisa retos enviados por alumnos y **aprueba o rechaza**
- Consulta el **ranking académico de los estudiantes**

### 👨‍💼 Administrador
- Crea y administra usuarios: alumnos, docentes, y otros administradores
- Asigna roles y grados
- **Registra nuevos logros y retos**
- Sube premios disponibles para el canje
- **Genera reportes**: ranking, docentes, canjes realizados

---

## ⚙️ Estado del proyecto

- [x] Módulo de login funcional con validación por rol y estado
- [x] Redirección a panel correspondiente según rol
- [x] Panel del administrador funcional (gestión de usuarios y roles)
- [ ] Conexión completa con base de datos (en progreso)
- [ ] Funcionalidad de retos, logros y canjes (en desarrollo)
- [ ] Interfaz visual y mejoras de experiencia (pendiente)

---

## 🛠 Tecnologías utilizadas

- Java (JSP / Servlets)
- NetBeans
- HTML / CSS
- MySQL
- Git & GitHub

---

## 🚀 Cómo ejecutar el sistema

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/ch4lzeus/SIMEL.git

2. Abrir el proyecto en NetBeans

3. Configurar la conexión a una base de datos MySQL

4. Ejecutar en un servidor como GlassFish o Tomcat

5. Acceder al sistema con credenciales de prueba


-- 

## 📈 Avances

El sistema ya cuenta con módulos clave conectados a la base de datos (login, validación de roles, creación de usuarios). La estructura para docentes, alumnos y administrador está implementada y el desarrollo está enfocado ahora en integrar funcionalidades dinámicas como retos, canjes y reportes.

--

## 👤 Autor

Luis Chalan
Correo: u17301049@utp.edu.pe
Universidad Tecnológica del Perú – 2025
