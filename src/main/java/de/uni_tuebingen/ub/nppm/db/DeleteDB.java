package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class DeleteDB extends AbstractBase {

    public static void updateAttribute(String table, String attribute, int id) throws Exception {
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            NativeQuery query = session.createNativeQuery("UPDATE " + table + " SET " + attribute + "= :value WHERE ID= :id");
            query.setParameter("value", null);
            query.setParameter("id", id);
            query.executeUpdate();
            session.getTransaction().commit();
        }
    }

    public static String selectAttribute(String table, String attribute, int id) throws Exception {
        String result = null;
        try ( Session session = getSession()) {
            session.getTransaction().begin();
            String sql = "SELECT " + attribute + " FROM " + table + " WHERE ID= " + id; // SQL-Abfrage erstellen

            NativeQuery query = session.createNativeQuery(sql);
            Object queryResult = query.uniqueResult();
            if (queryResult != null) {
                result = queryResult.toString(); // Wenn das Ergebnis nicht null ist, setze result auf den Wert
            }
            session.getTransaction().commit();
        }
        return result;
    }
}//end Class