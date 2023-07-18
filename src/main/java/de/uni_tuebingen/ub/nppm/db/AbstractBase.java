package de.uni_tuebingen.ub.nppm.db;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.query.Query;
import org.hibernate.service.ServiceRegistry;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

public class AbstractBase {

    protected static SessionFactory sessionFactory;

    protected static javax.naming.InitialContext initialContext = null;

    public static void setInitialContext(javax.naming.InitialContext ctx) {
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
            if (initialContext == null) {
                initialContext = new javax.naming.InitialContext();
            }
            settings.put(Environment.DRIVER, "com.mysql.cj.jdbc.Driver");
            settings.put(Environment.URL, (String) initialContext.lookup("java:comp/env/sqlURL"));
            settings.put(Environment.USER, (String) initialContext.lookup("java:comp/env/sqlUser"));
            settings.put(Environment.PASS, (String) initialContext.lookup("java:comp/env/sqlPassword"));

            settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL8Dialect");
            settings.put(Environment.SHOW_SQL, "true");
            settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");
            settings.put(Environment.HBM2DDL_AUTO, "validate");

            settings.put("hibernate.connection.CharSet", "utf8mb4");
            settings.put("hibernate.connection.useUnicode", true);
            settings.put("hibernate.connection.characterEncoding", "utf-8");

            settings.put("hibernate.connection.provider_class", "org.hibernate.connection.C3P0ConnectionProvider");
            settings.put("hibernate.c3p0.min_size", "5");
            settings.put("hibernate.c3p0.max_size", "150");
            settings.put("hibernate.c3p0.timeout", "30");
            settings.put("hibernate.c3p0.idle_test_period", "10");
            settings.put("hibernate.c3p0.preferredTestQuery", "SELECT 1");

            configuration.setProperties(settings);

            // TODO: Add all model classes dynamically
            configuration.addAnnotatedClass(Benutzer.class);
            configuration.addAnnotatedClass(BenutzerGruppe.class);

            configuration.addAnnotatedClass(Edition.class);
            configuration.addAnnotatedClass(EditionBand.class);
            configuration.addAnnotatedClass(EditionBestand.class);
            configuration.addAnnotatedClass(EditionEditor.class);

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
            configuration.addAnnotatedClass(UrkundeEmpfaenger.class);

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

            configuration.addAnnotatedClass(Content.class);

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
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            if (criteria == null) {
                criteria = builder.createQuery(c);
            }
            Root root = criteria.from(c);
            criteria.select(root);
            return session.createQuery(criteria).getResultList();
        }
    }

    protected static List getList(Class c) throws Exception {
        return getList(c, null);
    }

    public static void remove(Class class_, int id) throws Exception {
        try (Session session = getSession()) {
            Transaction transaction = session.getTransaction();
            transaction.begin();
            //Load
            Object obj = session.load(class_, id);
            //Remove
            session.remove(obj);
            //Commit
            transaction.commit();
        }
    }

    public static List<Object[]> getListNative(String sql) throws Exception {
        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            List<Object[]> rows = sqlQuery.getResultList();
            return rows;
        }
    }

    public static Object[] getRowNative(String sql) throws Exception {
        List<Object[]> list = getListNative(sql);
        if (!list.isEmpty())
            return list.get(0);

        return null;
    }

    public static Integer getIntNative(String sql) throws Exception {
        // This function is needed because if we use getRowNative or getListNative
        // we will have problems to cast a BigInteger to an Object, so we cast to
        // Int instead.
        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            //sqlQuery.setMaxResults(1);
            List<Object> rows = sqlQuery.getResultList();
            if (!rows.isEmpty() && rows.get(0) != null)
                return Integer.parseInt(rows.get(0).toString());
        }

        return null;
    }

    protected static void insertOrUpdate(String sql) throws Exception {
        try (Session session = getSession()) {
            session.getTransaction().begin();
            NativeQuery query = session.createNativeQuery(sql);
            query.executeUpdate();
            session.getTransaction().commit();
        }
    }

    protected static List<Map> getMappedList(Query query) throws Exception {
        // Result transformers are deprecated in Hibernate 5 but Hibernate 6 is not available yet with a proper replacement, so we can still use them.
        query.setResultTransformer(org.hibernate.transform.AliasToEntityMapResultTransformer.INSTANCE);
        return query.list();
    }

    protected static List<Map> getMappedList(CriteriaQuery criteria) throws Exception {
        try (Session session = getSession()) {
            return getMappedList(session.createQuery(criteria));
        }
    }

    public static List<Map> getMappedList(String query) throws Exception {
        // Note: If you wanna use this function properly and your query
        // contains a JOIN, please make sure to provide aliases (using AS)
        // to be able to access the result columns by key.
        try (Session session = getSession()) {
            return getMappedList(session.createNativeQuery(query));
        }
    }

    public static int getLinecount(String tablesString, String conditionsString) throws Exception {
        String sql = "SELECT COUNT(*) FROM " + tablesString + " WHERE (" + conditionsString + ")";
        return getIntNative(sql);
    }
}
