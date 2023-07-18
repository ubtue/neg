package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class FrontendExtendedSearch extends AbstractBase {

    public static List<Map<String, String>> getSearchResult(String fieldsString, String tablesString, String conditionsString, String order, String[] fields) throws Exception {
        String sql = "SELECT DISTINCT "+fieldsString+" FROM "+tablesString+" WHERE ("+conditionsString+") "+order;
        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createSQLQuery(sql);
            List<Object[]> rows = sqlQuery.getResultList();
            //return var
            List<Map<String, String>> ret = new ArrayList<Map<String, String>>();
            //loop over the rows
            for (Object[] row : rows) {
                //convert the fields from the row to a map
                Map<String, String> fieldVal = new HashMap<String, String>();
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
}
