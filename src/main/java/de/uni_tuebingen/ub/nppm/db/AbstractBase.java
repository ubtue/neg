package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.util.NamespaceHelper;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.query.Query;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import java.net.URI;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.type.StringType;

public class AbstractBase {

    protected static SessionFactory sessionFactory;

    protected static javax.naming.InitialContext initialContext = null;

    public static Map<String, Class> tableNameToEntityMap = initTableNameToEntityMap();

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

            settings.put("hibernate.cache.use_query_cache", "true");
            settings.put("hibernate.cache.use_second_level_cache", "true");
            settings.put("hibernate.cache.region.factory_class", "org.hibernate.cache.ehcache.EhCacheRegionFactory");

            configuration.setProperties(settings);

            // Add all model classes dynamically
            for (Class c : NamespaceHelper.getClassesOfPackage("de.uni_tuebingen.ub.nppm.model")) {
                if (c.isAnnotationPresent(Entity.class)) {
                    configuration.addAnnotatedClass(c);
                }
            }

            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties()).build();
            System.out.println("Hibernate Java Config serviceRegistry created");
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
        }
        return sessionFactory;
    }

    protected static Map<String, Class> initTableNameToEntityMap() throws RuntimeException {
        Map<String, Class> map = new HashMap<>();
        try {
            for (Class<?> c : NamespaceHelper.getClassesOfPackage("de.uni_tuebingen.ub.nppm.model")) {
                if (c.isAnnotationPresent(Entity.class)) {
                    Table table = (Table) c.getAnnotation(Table.class);
                    map.put(table.name(), c);
                }
            }
        } catch (Exception e) {
            // We need to convert this to a RuntimeException, since it is the only one
            // that may be used when generating a static class variable.
            throw new RuntimeException(e);
        }
        return map;
    }

    public static <T> T getById(int id, Class<T> class_) throws Exception {
        try ( Session session = getSession()) {
            return (T) session.get(class_, id);
        }
    }

    public static Integer getMaxId(String tabelle) throws Exception {
        return getIntNative("SELECT max(ID) FROM " + tabelle);
    }

    public static Class getEntityClassByTableName(String tableName) throws Exception {
        Class c = tableNameToEntityMap.get(tableName);
        if (c == null) {
            throw new Exception("Entity class not found for table: " + tableName);
        }
        return c;
    }

    protected static String getDatabaseName() throws Exception {
        String url = (String) initialContext.lookup("java:comp/env/sqlURL");
        if (url.startsWith("jdbc:")) {
            URI uri = URI.create(url.substring("jdbc:".length()));
            return uri.getPath();
        }
        return null;
    }

    // For now, we open a new session each time this method is called.
    // Later, we might try to use a static session similar to the static SessionFactory.
    protected static Session getSession() throws Exception {
        return getSessionFactory().openSession();
    }

    protected static List getList(Class c, CriteriaQuery criteria) throws Exception {
        try ( Session session = getSession()) {
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
        try ( Session session = getSession()) {
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
        try ( Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            List<Object[]> rows = sqlQuery.getResultList();
            return rows;
        }
    }

    public static Object[] getRowNative(String sql) throws Exception {
        List<Object[]> list = getListNative(sql);
        if (!list.isEmpty()) {
            return list.get(0);
        }

        return null;
    }

    public static Integer getIntNative(String sql) throws Exception {
        // This function is needed because if we use getRowNative or getListNative
        // we will have problems to cast a BigInteger to an Object, so we cast to
        // Int instead.
        try ( Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            //sqlQuery.setMaxResults(1);
            List<Object> rows = sqlQuery.getResultList();
            if (!rows.isEmpty() && rows.get(0) != null) {
                return Integer.parseInt(rows.get(0).toString());
            }
        }

        return null;
    }

    public static String getStringNative(String sql) throws Exception {
        try ( Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            //sqlQuery.setMaxResults(1);
            List<Object> rows = sqlQuery.getResultList();
            if (!rows.isEmpty() && rows.get(0) != null) {
                return rows.get(0).toString();
            }
        }

        return null;
    }

    public static List<String> getStringListNative(String sql) throws Exception {
        try ( Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            List<String> rows = sqlQuery.getResultList();
            return rows;
        }
    }

    public static Timestamp getTimestampNative(String sql) throws Exception {
        try ( Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            //sqlQuery.setMaxResults(1);
            List<Timestamp> rows = sqlQuery.getResultList();
            if (!rows.isEmpty() && rows.get(0) != null) {
                return rows.get(0);
            }
        }

        return null;
    }

    protected static String buildAndConditions(Map<String, String> andConditions) {
        String sql = "";

        int i = 0;
        for (Map.Entry<String, String> andCondition : andConditions.entrySet()) {
            if (i == 0) {
                sql += " WHERE ";
            } else {
                sql += " AND ";
            }

            sql += andCondition.getKey();  //z.b PersonID
            if (andCondition.getValue() == null) {
                sql += " IS ";
            } else {
                sql += " = ";
            }
            sql += ":" + andCondition.getKey(); //z.b :PersonID  (kreiere Platzhalter mit .getKey()  nicht .getValue
            i++;
        }

        return sql;
    }

    //Hilsfunktion zum setzen der Parameter
    protected static void registerAndConditions(Map<String, String> andConditions, NativeQuery query) {
        for (Map.Entry<String, String> andCondition : andConditions.entrySet()) {

            if (andCondition.getKey().equals("QuelleBisJahrhundert") || andCondition.getKey().equals("QuelleVonJahrhundert") || andCondition.getKey().equals("VonJahrhundert") || andCondition.getKey().equals("BisJahrhundert")) {
                query.setParameter(andCondition.getKey(), andCondition.getValue(), StringType.INSTANCE);
            } else {
                query.setParameter(andCondition.getKey(), andCondition.getValue());
            }
        }
    }

    protected static void registerAndConditions(Map<String, String> conditions, NativeQuery query, List<String> specialColumns) {
        for (Map.Entry<String, String> andCondition : conditions.entrySet()) {
            if (specialColumns != null && specialColumns.contains(andCondition.getKey())) {
                query.setParameter(andCondition.getKey(), andCondition.getValue(), StringType.INSTANCE);
            } else {
                query.setParameter(andCondition.getKey(), andCondition.getValue());
            }
        }
    }

    public static void update(String table, Map<String, String> attributesAndValues, Map<String, String> andConditions, List<String> specialColumns) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            String sql = "UPDATE " + table + " SET ";

            int i = 0;
            for (Map.Entry<String, String> attributeAndValue : attributesAndValues.entrySet()) {
                if (i == 0) {
                    sql += attributeAndValue.getKey() + " = :" + attributeAndValue.getKey();
                } else {
                    sql += ", " + attributeAndValue.getKey() + " = :" + attributeAndValue.getKey();
                }
                i++;

            }

            sql += buildAndConditions(andConditions);

            NativeQuery query = session.createNativeQuery(sql);

            registerAndConditions(attributesAndValues, query, specialColumns);
            registerAndConditions(andConditions, query);

            query.executeUpdate();
            session.getTransaction().commit();
        }
    }

    public static void update(String table, String attribute, String value, Map<String, String> andConditions) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            String sql = "UPDATE " + table + " SET " + attribute + "= :value";
            sql += buildAndConditions(andConditions);

            NativeQuery query = session.createNativeQuery(sql);
            query.setParameter("value", value);
            registerAndConditions(andConditions, query);

            query.executeUpdate();
            session.getTransaction().commit();
        }
    }

    public static String getSingleField(String zielAttribut, String zieltabelle, int id) throws Exception {
        String sql = "SELECT " + zielAttribut + " FROM " + zieltabelle + " WHERE ID='" + id + "';";
        try {
            Object res = DatenbankDB.getSingleResult(sql);
            if (res != null) {
                return res.toString();
            }
            return null;
        } catch (Exception exception) {
            throw new Exception(exception.getLocalizedMessage() + "\nSQL: " + sql);
        }
    }

    protected static void insertOrUpdate(String sql) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            NativeQuery query = session.createNativeQuery(sql);
            query.executeUpdate();
            session.getTransaction().commit();
        }
    }

    protected static List<Map> getMappedListString(Query query) throws Exception {

        query.setResultTransformer(AliasToCaseInsensitiveEntityMapResultTransformer.INSTANCE);

        List<Map> resultList = new ArrayList<>();
        List<Map> rows = query.list();

        for (Map row : rows) {
            Map<String, String> stringRowMap = new HashMap<>();
            for (Object entryObject : row.entrySet()) {
                Map.Entry<String, Object> entry = (Map.Entry<String, Object>) entryObject;
                String key = entry.getKey();
                String value = entry.getValue() != null ? entry.getValue().toString() : null;
                stringRowMap.put(key, value);
            }
            resultList.add(stringRowMap);
        }

        return resultList;
    }

    public static List<Map> getMappedListString(String query) throws Exception {
        // Note: If you wanna use this function properly and your query
        // contains a JOIN, please make sure to provide aliases (using AS)
        // to be able to access the result columns by key.
        try ( Session session = getSession()) {
            return getMappedListString(session.createNativeQuery(query));
        }
    }

    protected static List<Map> getMappedList(Query query) throws Exception {
        // Result transformers are deprecated in Hibernate 5 but Hibernate 6 is not available yet with a proper replacement, so we can still use them.
        query.setResultTransformer(AliasToCaseInsensitiveEntityMapResultTransformer.INSTANCE);
        return query.list();
    }

    protected static List<Map> getMappedList(CriteriaQuery criteria) throws Exception {
        try ( Session session = getSession()) {
            return getMappedList(session.createQuery(criteria));
        }
    }

    public static List<Map> getMappedList(String query) throws Exception {
        // Note: If you wanna use this function properly and your query
        // contains a JOIN, please make sure to provide aliases (using AS)
        // to be able to access the result columns by key.
        try ( Session session = getSession()) {
            return getMappedList(session.createNativeQuery(query));
        }
    }

    protected static Map getMappedRow(Query query) throws Exception {
        // Result transformers are deprecated in Hibernate 5 but Hibernate 6 is not available yet with a proper replacement, so we can still use them.
        query.setResultTransformer(AliasToCaseInsensitiveEntityMapResultTransformer.INSTANCE);
        query.setMaxResults(1);
        List<Map> rows = query.list();
        if (rows.isEmpty()) {
            return null;
        }
        return rows.get(0);
    }

    public static Map getMappedRow(String query) throws Exception {
        try ( Session session = getSession()) {
            return getMappedRow(session.createNativeQuery(query));
        }
    }

    public static int getLinecount(String tablesString, String conditionsString) throws Exception {
        String sql = "SELECT COUNT(*) FROM " + tablesString + " WHERE (" + conditionsString + ")";
        return getIntNative(sql);
    }

    public static Integer getMaxCharacterLength(String table, String column) throws Exception {
        String sql = "SELECT CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" + getDatabaseName() + "' AND TABLE_NAME = '" + table + "' AND COLUMN_NAME='" + column + "'";
        return getIntNative(sql);
    }

    protected static List<String> dynamicTablesWhitelist = Arrays.asList("edition", "einzelbeleg", "gast", "handschrift", "mgh_lemma", "namenkommentar", "person", "quelle", "selektion", "ueberlieferung", "urkunde");

    /**
     * This function is used to verify that a table name given by e.g. an AJAX
     * call is not abused for SQL injection.
     *
     * 1) A table name must only consist of allowed characters (e.g. no spaces
     * or colons) to prevent various attempts, e.g. by using UNION SELECT or
     * splitting into multiple statements. 2) A table name must start with a
     * prefix (or exactly match an allowed table in a whitelist) to make sure it
     * is not used to e.g. select user-related information from the "benutzer"
     * table.
     */
    public static void verifyDynamicTable(String table, String prefix) throws SqlInjectionException {
        // This function is used to verify that a string only contains characters
        // that are allowed within MySQL table names
        // to prevent SQL injection.
        if (!table.matches("^[a-zA-Z0-9_]+$")) {
            throw new SqlInjectionException("Invalid table name: " + table);
        }

        if ((prefix != null && !table.startsWith(prefix)) || !dynamicTablesWhitelist.stream().anyMatch(s -> table.startsWith(s))) {
            throw new SqlInjectionException("Using this table in a dynamic SQL query is not allowed: " + table);
        }
    }

    public static void verifyDynamicTable(String table) throws SqlInjectionException {
        verifyDynamicTable(table, null);
    }

    /**
     * Similar to verifyDynamicTable, but here we only check that only valid
     * characters are used to prevent UNION SELECT or multi-query attacks.
     */
    public static void verifyDynamicColumn(String column) throws SqlInjectionException {
        if (!column.matches("^[a-zA-Z0-9_]+$")) {
            throw new SqlInjectionException("Invalid column name: " + column);
        }
    }
}
