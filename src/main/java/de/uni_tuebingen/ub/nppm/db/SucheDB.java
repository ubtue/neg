package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Root;
import javax.persistence.Tuple;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.Criteria;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class SucheDB extends AbstractBase {

    public static List getFavoriten() throws Exception {
        return getList(SucheFavoriten.class);
    }

    public static List<String> getCountryText(String country, String form, String query) throws Exception {
        String sql = "SELECT DISTINCT " + country + " FROM " + form;
        if (!query.equals("?")) {
            sql += " WHERE " + country + " LIKE '%" + query + "%' ";
        }
        sql += " ORDER BY " + country;

        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            List<String> rows = sqlQuery.getResultList();
            return rows;
        }
    }

    public static Map<Integer, String> getAttributes(HttpServletRequest request) throws Exception {
        String dbForm = request.getParameter("dbForm");
        String tabelle = request.getParameter("zwischentabelle");
        String zwAttribut = request.getParameter("zwAttribut");
        String attribut = request.getParameter("attribut");

        Map<Integer, String> ret = new HashMap<Integer, String>();
        try (Session session = getSession()) {
            Transaction tx = session.beginTransaction();
            String sql = "SELECT ID, " + attribut + " FROM " + dbForm + " e WHERE NOT EXISTS (SELECT * FROM " + tabelle + " eh WHERE e.ID=eh." + zwAttribut + ") ORDER BY " + attribut;
            NativeQuery query = session.createNativeQuery(sql);
            List<Object[]> rows = query.list();

            for (Object[] row : rows) {
                if (row[0] != null && row[1] != null) {
                    ret.put(Integer.valueOf(row[0].toString()), row[1].toString());
                }
            }

            return ret;
        }
    }

    public static List getFields(String fields, String tablesString, String conditionsString, String export, Integer pageoffset, Integer pageLimit) throws Exception {
        String sql = "SELECT " + fields + " FROM " + tablesString + " WHERE (" + conditionsString + ")";
        if (export != null && (export.equals("liste") || export.equals("browse")) && pageoffset != null && pageLimit != null) {
            sql += " LIMIT " + (pageoffset * pageLimit) + ", " + pageLimit;
        }

        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);

            sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);

            return sqlQuery.getResultList();
        }
    }

    public static List<Map<String, String>> getSearchResult(String fieldsString, String tablesString, String conditionsString, String orderString, String order, String[] fields) throws Exception {
        String sql = "SELECT DISTINCT " + fieldsString + " FROM " + tablesString + " WHERE (" + conditionsString + ") " + order;
        if (order.equals("")) {
            sql += orderString;
        }

        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            List<Object[]> rows = sqlQuery.getResultList();
            //return var
            List<Map<String, String>> ret = new ArrayList<>();
            //loop over the rows
            for (Object[] row : rows) {
                //convert the fields from the row to a map
                Map<String, String> fieldVal = new HashMap<>();
                for (int i = 0; i < fields.length; i++) {
                    String[] name = fields[i].split(" AS ");
                    if (name.length == 2) {
                        fields[i] = name[1];
                    }
                    if (row[i] != null) {
                        fieldVal.put(fields[i].trim(), row[i].toString());
                    }
                }
                ret.add(fieldVal);
            }

            return ret;
        }
    }

    public static List<Object[]> getSearchCount(String conditionsString, String countString, String tablesString) throws Exception {
        List<Object[]> ret = new ArrayList<>();
        String sql = "SELECT " + countString + " FROM " + tablesString + " WHERE (" + conditionsString + ")";

        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            List rows = sqlQuery.list();

            for (Object object : rows) {
                //if object is not an array, cast it to a one dim array
                if (!object.getClass().isArray()) {
                    Object[] arr = new Object[1];
                    arr[0] = object;
                    ret.add(arr);
                    return ret;
                } else {
                    ret.add((Object[]) object);
                }
            }
            return ret;
        }
    }

    public static List<SucheErgebnis> getExtended(SucheOptionen suchoptionen) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Tuple> query = builder.createTupleQuery();

            Root rootEinzelbeleg = query.from(Einzelbeleg.class);
            Join<Einzelbeleg, Quelle> joinQuelle = rootEinzelbeleg.join(Einzelbeleg_.QUELLE, JoinType.LEFT);
            Join<Einzelbeleg, Person> joinPerson = rootEinzelbeleg.join(Einzelbeleg_.PERSON);

            // If you add / change the parameters here, make sure to also change the calls for tuple.get() below
            query.multiselect(rootEinzelbeleg, joinQuelle, joinPerson);

            if (suchoptionen.quelleZuVeroeffentlichen) {
                query.where(builder.equal(joinQuelle.get(Quelle_.zuVeroeffentlichen), 1));
            }
            if (suchoptionen.einzelbelegBelegform != null) {
                query.where(builder.equal(rootEinzelbeleg.get(Einzelbeleg_.BELEGFORM), suchoptionen.einzelbelegBelegform));
            }

            Query preparedQuery = session.createQuery(query);
            if (suchoptionen.limit > 0) {
                preparedQuery.setMaxResults(suchoptionen.limit);
            }

            // Convert result into structured data
            List<Tuple> resultList = preparedQuery.getResultList();
            List<SucheErgebnis> endResultList = new ArrayList<>();
            for (Tuple tuple : resultList) {
                SucheErgebnis endResult = new SucheErgebnis();

                // The order of objects for tuple.get() must be similar to query.multiselect()
                endResult.einzelbeleg = tuple.get(0, Einzelbeleg.class);
                endResult.quelle = tuple.get(1, Quelle.class);
                endResult.person = tuple.get(2, Person.class);

                endResultList.add(endResult);
            }
            return endResultList;
        }
    }

    public static List<Map> getEinfacheSucheResult(String sql) throws Exception {
        return getMappedList(sql);
    }

}
