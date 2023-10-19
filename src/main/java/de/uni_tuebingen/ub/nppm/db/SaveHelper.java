package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.DatenbankMapping;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class SaveHelper extends AbstractBase {

    public static boolean existForm(String form, int id) throws Exception {
        return DatenbankDB.getSingleResult("SELECT * FROM " + form + " WHERE ID=" + id) != null;
    }

    public static void insertMetaData(String form, int id, int benutzerID, int gruppenID) throws Exception {
        String sql = "INSERT INTO " + form + " (ID, Erstellt, ErstelltVon, GehoertGruppe)"
                + " VALUES(" + id + ", NOW(), " + benutzerID + ", " + gruppenID + ");";
        insertOrUpdate(sql);
    }

    public static List<Map> getAttribute(String table, String attribute, Map andConditions) throws Exception {
        List<Map> results = new ArrayList<>();

        try ( Session session = getSession()) {
            String sql = "SELECT " + attribute + " FROM " + table; // SQL-Abfrage erstellen
            sql += buildAndConditions(andConditions); // Bedingungen hinzufügen

            NativeQuery query = session.createNativeQuery(sql);
            registerAndConditions(andConditions, query);

            if (attribute.equals("*")) {
                List<Object[]> queryResults = query.getResultList(); // Ergebnisse aus der Datenbank

                for (Object[] row : queryResults) {
                    Map<String, String> resultRow = new HashMap<>();
                    resultRow.put(attribute, row[0].toString()); // Wert zur HashMap hinzufügen
                    results.add(resultRow);
                }
            } else {
                List<String> queryResults = query.getResultList(); // Ergebnisse aus der Datenbank
                for (String value : queryResults) {
                    Map<String, String> resultRow = new HashMap<>();
                    resultRow.put(attribute, value); // Wert zur HashMap hinzufügen
                    results.add(resultRow);
                }
            }
        }
        return results;
    }

    public static List<Map> getAttributeMap(String table, String attributeString, int id) throws Exception {
        List<Map> results = new ArrayList<>();

        try ( Session session = getSession()) {

            String sql = "SELECT " + attributeString + " FROM " + table + " WHERE ID = " + id; // SQL-Abfrage erstellen

            List<Object[]> queryResults = AbstractBase.getListNative(sql); // Ergebnisse aus der Datenbank als Liste von Object-Arrays

            for (Object[] row : queryResults) {
                Map<String, Object> rowMap = new HashMap<>();

                // Die Spaltenwerte in die Map einfügen, wobei die Spaltennamen als Schlüssel verwendet werden
                for (int i = 0; i < row.length; i++) {
                    String columnName = attributeString.split(",")[i].trim(); // Die Spaltennamen sind mit Kommas getrennt
                    rowMap.put(columnName, row[i]);
                }

                results.add(rowMap);
            }
        }
        return results;
    }

    public static List<Map> getMapField(String zieltabelle, int id) throws Exception {
        String sql = "SELECT * FROM " + zieltabelle + " WHERE ID = " + id; // SQL-Abfrage erstellen

        return AbstractBase.getMappedListString(sql);
    }

    public static void updateMetaData(String form, int id, int benutzerID) throws Exception {
        String sql = "UPDATE " + form + " SET LetzteAenderung = NOW(), LetzteAenderungVon=\"" + benutzerID + "\" WHERE ID=" + id + ";";
        insertOrUpdate(sql);
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

    public static void insert(String table, Map<String, String> columnsAndValues) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();

            String sql = "INSERT INTO " + table + " (";
            List<String> columnNames = new ArrayList<>();
            List<String> valuePlaceholders = new ArrayList();

            for (Map.Entry<String, String> entry : columnsAndValues.entrySet()) {
                String value = entry.getValue();
                if (value != null && !value.isEmpty()) {
                    columnNames.add(entry.getKey());
                    valuePlaceholders.add(":" + entry.getKey());
                }
            }

            if (!columnNames.isEmpty()) {
                sql += String.join(", ", columnNames) + ") VALUES (" + String.join(", ", valuePlaceholders) + ")";

                NativeQuery query = session.createNativeQuery(sql);

                for (Map.Entry<String, String> entry : columnsAndValues.entrySet()) {
                    String value = entry.getValue();
                    if (value != null && !value.isEmpty()) {
                        query.setParameter(entry.getKey(), value);
                    }
                }
                query.executeUpdate();
            }
            session.getTransaction().commit();
        }
    }

    public static void deleteAttribute(String table, Map<String, String> andConditions) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            String sql = "DELETE FROM " + table;
            sql += buildAndConditions(andConditions);

            NativeQuery query = session.createNativeQuery(sql);
            registerAndConditions(andConditions, query);

            query.executeUpdate();
            session.getTransaction().commit();
        }
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
            query.setParameter(andCondition.getKey(), andCondition.getValue());
        }
    }

    public static List<DatenbankMapping> getMapping(String formular) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<DatenbankMapping> criteria = criteriaBuilder.createQuery(DatenbankMapping.class);
            Root<DatenbankMapping> root = criteria.from(DatenbankMapping.class);
            criteria.select(root).where(
                    criteriaBuilder.and(
                            criteriaBuilder.equal(root.get("formular"), formular)
                    )
            );
            org.hibernate.query.Query query = session.createQuery(criteria);
            List<DatenbankMapping> rows = query.getResultList();
            return rows;
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

    public static void insertOrUpdateSql(String sql) throws Exception {
        try {
            insertOrUpdate(sql);
        } catch (Exception exception) {
            throw new Exception(exception.getLocalizedMessage() + "\nSQL: " + sql);
        }
    }
}
