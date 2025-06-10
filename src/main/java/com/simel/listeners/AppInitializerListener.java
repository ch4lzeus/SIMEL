package com.simel.listeners; // Paquete donde resides tu listener.

// --- Imports Necesarios ---
import com.simel.conexion.DataSourceProvider; // Importa tu clase que gestiona el pool.
import com.zaxxer.hikari.HikariDataSource;   // Necesario para poder llamar al método close() específico de HikariCP.
import javax.sql.DataSource;               // Interfaz estándar para el pool.
import javax.servlet.ServletContextEvent;    // Objeto que representa el evento de inicialización/destrucción del contexto de la aplicación.
import javax.servlet.ServletContextListener; // La interfaz que debemos implementar para escuchar eventos del ciclo de vida de la aplicación.
import javax.servlet.annotation.WebListener; // Anotación estándar para que el servidor (Tomcat) detecte y registre este listener automáticamente.
// -------------------------

/**
 * Esta clase actúa como un "oyente" del ciclo de vida de la aplicación web.
 * Gracias a la interfaz ServletContextListener y la anotación @WebListener, el
 * servidor ejecutará automáticamente los métodos definidos aquí cuando la
 * aplicación arranque y cuando se detenga.
 *
 * Su propósito principal en este proyecto es asegurar que el pool de conexiones
 * (DataSource) se inicialice correctamente al inicio y se cierre de forma
 * ordenada al final.
 */
@WebListener // ¡Fundamental! Registra esta clase como un listener en el servidor.
public class AppInitializerListener implements ServletContextListener {

    /**
     * Este método es llamado por el servidor UNA SOLA VEZ cuando la aplicación
     * web se inicia (antes de que procese la primera petición). Es el lugar
     * ideal para realizar tareas de inicialización globales.
     *
     * @param sce El evento que contiene información sobre el contexto de la
     * aplicación.
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Mensaje de log para saber cuándo se ejecuta este método.
        // sce.getServletContext().getContextPath() devuelve el nombre de tu aplicación web (ej: /SIMEL_2_0)
        System.out.println("Inicializando aplicación web (Listener)..." + sce.getServletContext().getContextPath());
        try {
            // Llamamos a DataSourceProvider.getDataSource(). 
            // Esto tiene el efecto secundario de forzar la ejecución del bloque 'static' 
            // en DataSourceProvider si aún no se ha ejecutado, asegurando así que 
            // el pool de conexiones se configure y cree al arrancar la aplicación.
            DataSource ds = DataSourceProvider.getDataSource();
            // Verificación simple para confirmar en los logs que se obtuvo el DataSource.
            if (ds != null) {
                System.out.println("DataSourceProvider inicializado correctamente desde Listener.");
            } else {
                // Si ds es null aquí, algo falló gravemente en el bloque static de DataSourceProvider.
                System.err.println("Error: DataSourceProvider devolvió null desde Listener.");
            }
        } catch (Exception e) {
            // Captura cualquier excepción inesperada durante la inicialización del DataSource.
            // Es importante loguear esto porque podría impedir que la aplicación funcione.
            System.err.println("Error CRÍTICO inicializando DataSourceProvider desde Listener: " + e.getMessage());
            e.printStackTrace();
            // Podrías considerar lanzar una excepción aquí para detener el despliegue si la BD es esencial.
        }
    }

    /**
     * Este método es llamado por el servidor UNA SOLA VEZ cuando la aplicación
     * web se detiene (ej: cuando paras Tomcat o redespliegas la aplicación). Es
     * el lugar ideal para realizar tareas de limpieza y liberación de recursos.
     *
     * @param sce El evento que contiene información sobre el contexto de la
     * aplicación.
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Mensaje de log para saber cuándo se está deteniendo la aplicación.
        System.out.println("Deteniendo aplicación web (Listener)..." + sce.getServletContext().getContextPath());

        // Obtenemos la instancia del DataSource que creamos al inicio.
        DataSource ds = DataSourceProvider.getDataSource();

        // Verificamos si el DataSource es realmente una instancia de HikariDataSource.
        // Esto es necesario porque el método close() específico para cerrar el pool
        // pertenece a HikariDataSource, no a la interfaz genérica DataSource.
        if (ds instanceof HikariDataSource) {
            System.out.println("Cerrando HikariCP DataSource...");
            // Hacemos un cast a HikariDataSource para poder llamar a su método close().
            // Esto cierra todas las conexiones físicas del pool y libera los recursos asociados.
            ((HikariDataSource) ds).close();
            System.out.println("HikariCP DataSource cerrado.");
        } else if (ds != null) {
            // Si obtuvimos un DataSource pero no es HikariDataSource (raro en este caso, pero posible si se cambia la implementación).
            System.err.println("El DataSource obtenido no es una instancia de HikariDataSource, no se puede cerrar explícitamente de esta forma.");
        } else {
            // Si no pudimos obtener el DataSource (quizás nunca se inicializó correctamente).
            System.err.println("No se pudo obtener el DataSource para cerrar.");
        }

// 🔴 Cierre del hilo de limpieza de MySQL (opcional pero recomendado)
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread cerrado correctamente.");
        } catch (Exception e) {
            System.err.println("Error al cerrar AbandonedConnectionCleanupThread: " + e.getMessage());
            e.printStackTrace();
        }

    }
}
