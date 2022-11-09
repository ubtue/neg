package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

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
    public static Map<Integer, String> getAttributes(HttpServletRequest request) throws Exception{
        String dbForm=request.getParameter("dbForm");
        String tabelle=request.getParameter("zwischentabelle");
        String zwAttribut=request.getParameter("zwAttribut");
        String attribut=request.getParameter("attribut");
        
        Map<Integer, String> ret = new HashMap<Integer,String>();
        Session session = getSession();  
        Transaction tx = session.beginTransaction();
        String sql = "select ID, "+attribut+" from "+dbForm+" e where not exists (select * from "+tabelle+" eh where e.ID=eh."+zwAttribut+") order by " + attribut;
        SQLQuery query = session.createSQLQuery(sql);
        List<Object[]> rows = query.list();
        
        for(Object[] row : rows){
            if(row[0] != null && row[1] != null){
                ret.put(Integer.valueOf(row[0].toString()), row[1].toString());
            }
        }     
        
        return ret;
    }
}
