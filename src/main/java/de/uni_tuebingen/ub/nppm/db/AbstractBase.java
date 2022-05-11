package de.uni_tuebingen.ub.nppm.db;

import java.util.Properties;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import de.uni_tuebingen.ub.nppm.model.*;

public class AbstractBase {
    protected static SessionFactory sessionFactory;

    // Example taken from: https://www.javaguides.net/2019/08/hibernate-5-one-to-many-mapping-annotation-example.html
    protected static SessionFactory getSessionFactory() throws Exception {
        if (sessionFactory == null) {
            // Hibernate settings equivalent to hibernate.cfg.xml's properties
            Configuration configuration = new Configuration();

            // Hibernate settings equivalent to hibernate.cfg.xml's properties
            Properties settings = new Properties();

            // Get settings from tomcat config
            javax.naming.InitialContext initialContext = new javax.naming.InitialContext();
            settings.put(Environment.DRIVER, "com.mysql.jdbc.Driver");
            settings.put(Environment.URL, (String)initialContext.lookup("java:comp/env/sqlURL"));
            settings.put(Environment.USER, (String)initialContext.lookup("java:comp/env/sqlUser"));
            settings.put(Environment.PASS, (String)initialContext.lookup("java:comp/env/sqlPassword"));

            // This must be changed when migrating to InnoDB
            //settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL5InnoDBDialect");
            settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQLMyISAMDialect");
            settings.put(Environment.SHOW_SQL, "true");
            settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");
            settings.put(Environment.HBM2DDL_AUTO,"validate");

            configuration.setProperties(settings);

            // TODO: Add all model classes dynamically
            configuration.addAnnotatedClass(Benutzer.class);
            configuration.addAnnotatedClass(BenutzerGruppe.class);
            
            configuration.addAnnotatedClass(Edition.class);
            configuration.addAnnotatedClass(EditionBand.class);
            configuration.addAnnotatedClass(EditionBestand.class);
            configuration.addAnnotatedClass(EditionHatEditor.class);

            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                .applySettings(configuration.getProperties()).build();
            System.out.println("Hibernate Java Config serviceRegistry created");
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
        }
        return sessionFactory;
    }

    // For now, we open a new session each time this method is called.
    // Later, we might try to use a static session similar to the static SessionFactory.
    protected static Session getSession() throws Exception {
        return getSessionFactory().openSession();
    }
}
