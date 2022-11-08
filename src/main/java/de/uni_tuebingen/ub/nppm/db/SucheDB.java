package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class SucheDB extends AbstractBase {

    public static List getFavoriten() throws Exception {
        return getList(SucheFavoriten.class);
    }
    
    public static List<String> getCountries(String field, String form, String query) throws Exception {
        String sql = "Select distinct " + field + " from " + form;
        if (!query.equals("?")) {
            sql += " where " + field + " like '%" + query + "%' ";
        }
        sql += " order by " + field;

        Session session = getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        List<String> rows = sqlQuery.getResultList();
        return rows;
    }
}
