package de.uni_tuebingen.ub.nppm.util;

import com.mchange.v2.c3p0.C3P0Registry;
import com.mchange.v2.c3p0.PooledDataSource;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Iterator;
import java.util.Set;
import javax.servlet.*;
public class ContextListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        /*
            Close C3P0 Connection Pool
        */
        Iterator<Set> it = C3P0Registry.getPooledDataSources().iterator();
        while (it.hasNext()) {
            try {
                   PooledDataSource dataSource = (PooledDataSource) it.next();
                   dataSource.close();
            } catch (Exception e) {
                   e.printStackTrace();
            }
        }
        
        /*
            Shutdown AbandonedConnectionCleanupThread
        */
        try {
            AbandonedConnectionCleanupThread.checkedShutdown();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        /*
            Deregister drivers
        */
        while (DriverManager.getDrivers().hasMoreElements()) {
            try {
                Driver d = DriverManager.getDrivers().nextElement();
                DriverManager.deregisterDriver(d);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }            
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        
    }
}
