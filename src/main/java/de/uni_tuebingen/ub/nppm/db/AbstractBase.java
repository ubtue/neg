package de.uni_tuebingen.ub.nppm.db;

import java.util.Properties;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.SingularAttribute;

public class AbstractBase {
    protected static SessionFactory sessionFactory;
    
    protected static javax.naming.InitialContext initialContext =  null;
    
    public static void setInitialContext(javax.naming.InitialContext ctx){
        initialContext = ctx;
    }
    
    // Example taken from: https://www.javaguides.net/2019/08/hibernate-5-one-to-many-mapping-annotation-example.html
    protected static SessionFactory getSessionFactory() throws Exception {
        if (sessionFactory == null) {
            // Hibernate settings equivalent to hibernate.cfg.xml's properties
            Configuration configuration = new Configuration();

            // Hibernate settings equivalent to hibernate.cfg.xml's properties
            Properties settings = new Properties();

            // Get settings from tomcat config
            if(initialContext == null)
                initialContext = new javax.naming.InitialContext();
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

            configuration.addAnnotatedClass(SelektionAmtWeihe.class);
            configuration.addAnnotatedClass(SelektionAreal.class);
            configuration.addAnnotatedClass(SelektionAutor.class);
            configuration.addAnnotatedClass(SelektionBearbeitungsstatus.class);
            configuration.addAnnotatedClass(SelektionBewertung.class);
            configuration.addAnnotatedClass(SelektionDatGenauigkeit.class);
            configuration.addAnnotatedClass(SelektionEchtheit.class);
            configuration.addAnnotatedClass(SelektionEthnie.class);
            configuration.addAnnotatedClass(SelektionEthnienErhalt.class);
            configuration.addAnnotatedClass(SelektionFunktion.class);
            configuration.addAnnotatedClass(SelektionGeschlecht.class);
            configuration.addAnnotatedClass(SelektionGrammatikgeschlecht.class);
            configuration.addAnnotatedClass(SelektionJaNein.class);
            configuration.addAnnotatedClass(SelektionKasus.class);
            configuration.addAnnotatedClass(SelektionLebendVerstorben.class);
            configuration.addAnnotatedClass(SelektionQuellengattung.class);
            configuration.addAnnotatedClass(SelektionStand.class);
            configuration.addAnnotatedClass(SelektionUrkundeAusstellerEmpfaenger.class);
            configuration.addAnnotatedClass(SelektionVerwandtschaftsgrad.class);
            configuration.addAnnotatedClass(SelektionOrt.class);
            configuration.addAnnotatedClass(SelektionReihe.class);
            configuration.addAnnotatedClass(SelektionSammelband.class);
            configuration.addAnnotatedClass(SelektionDmghBand.class);
            configuration.addAnnotatedClass(SelektionBkz.class);
            configuration.addAnnotatedClass(SelektionEditor.class);

            configuration.addAnnotatedClass(MghLemma.class);
            configuration.addAnnotatedClass(MghLemmaBearbeiter.class);
            configuration.addAnnotatedClass(MghLemmaKorrektor.class);
            
            configuration.addAnnotatedClass(NamenKommentar.class);
            configuration.addAnnotatedClass(NamenKommentarBearbeiter.class);
            configuration.addAnnotatedClass(NamenKommentarKorrektor.class);
            
            configuration.addAnnotatedClass(Quelle.class);
            configuration.addAnnotatedClass(QuelleInEdition_MM.class);
            
            configuration.addAnnotatedClass(Handschrift.class);
            configuration.addAnnotatedClass(HandschriftUeberlieferung.class);
            
            configuration.addAnnotatedClass(Urkunde.class);
            configuration.addAnnotatedClass(UrkundeBetreff.class);
            configuration.addAnnotatedClass(UrkundeDorsalnotiz.class);
            
            configuration.addAnnotatedClass(Person.class);
            configuration.addAnnotatedClass(PersonAmtStandWeihe_MM.class);
            configuration.addAnnotatedClass(PersonQuiet.class);
            configuration.addAnnotatedClass(PersonVariante.class);
            configuration.addAnnotatedClass(PersonAreal_MM.class);
            configuration.addAnnotatedClass(PersonEthnie_MM.class);
            configuration.addAnnotatedClass(PersonVerwandtMit_MM.class);                        
            
            configuration.addAnnotatedClass(Einzelbeleg.class);
            configuration.addAnnotatedClass(EinzelbelegHatFunktion_MM.class);
            configuration.addAnnotatedClass(EinzelbelegTextkritik.class);
            configuration.addAnnotatedClass(EinzelbelegMghLemma_MM.class);
            configuration.addAnnotatedClass(EinzelbelegNamenkommentar_MM.class);
            configuration.addAnnotatedClass(EinzelbelegHatPerson_MM.class);

        
            configuration.addAnnotatedClass(DatenbankFilter.class);
            configuration.addAnnotatedClass(DatenbankMapping.class);
            configuration.addAnnotatedClass(DatenbankSelektion.class);
            configuration.addAnnotatedClass(DatenbankSprache.class);
            configuration.addAnnotatedClass(DatenbankTexte.class);

            configuration.addAnnotatedClass(SucheFavoriten.class);
            
            configuration.addAnnotatedClass(Bemerkung.class);

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

    protected static List getList(Class c, CriteriaQuery criteria) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        if(criteria == null){
            criteria = builder.createQuery(c);
        }
        Root root = criteria.from(c);
        criteria.select(root);
        return session.createQuery(criteria).getResultList();
    }

    protected static List getList(Class c) throws Exception {
        return getList(c, null);
    }
}