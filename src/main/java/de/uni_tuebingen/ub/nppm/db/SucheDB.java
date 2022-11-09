package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.ArrayList;
import java.util.Arrays;
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
    

    public static List<String> getCountryText(String country, String form, String query) throws Exception {
        String sql = "Select distinct " + country + " from " + form;
        if (!query.equals("?")) {
            sql += " where " + country + " like '%" + query + "%' ";
        }
        sql += " order by " + country;

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
    
    public static int getLinecount(String tablesString, String conditionsString) throws Exception {
        String sql = "SELECT COUNT(*) FROM "+tablesString+" WHERE ("+conditionsString+")";
        Session session = getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        sqlQuery.setMaxResults(1);
        List<Object> rows = sqlQuery.getResultList();
        return (int)rows.get(0);
    }
        
    public static List<Map<String,String>> getFields(String fields , String tablesString, String conditionsString, String export, int pageoffset, int pageLimit) throws Exception {
        String sql = "SELECT "+fields+" FROM "+tablesString+" WHERE ("+conditionsString+")";
        if (export.equals("liste") || export.equals("browse"))
            sql += " LIMIT "+(pageoffset*pageLimit)+", "+pageLimit;
        Session session = getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        List<Object[]> rows = sqlQuery.getResultList();
        //convert field str to list
        List<String> fieldList = new ArrayList<String>(Arrays.asList(fields.split(",")));
        List<Map<String,String>> ret = new ArrayList<Map<String,String>>();
        //loop over the rows
        for(Object[] row : rows){         
            //convert the fields from the row to a map
            Map<String, String> fieldVal = new HashMap<String, String>();
            for(int i = 0; i < fieldList.size(); i++){
                fieldVal.put(fieldList.get(i), row[i].toString());
            }
            ret.add(fieldVal);
        }
        
        return ret;
    }
}
