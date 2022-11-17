package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.math.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

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
        String sql = "SELECT ID, "+attribut+" FROM "+dbForm+" e WHERE NOT EXISTS (SELECT * FROM "+tabelle+" eh WHERE e.ID=eh."+zwAttribut+") ORDER BY " + attribut;
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
                fieldVal.put(fieldList.get(i).trim(), row[i].toString());
            }
            ret.add(fieldVal);
        }
        
        return ret;
    }
    
    public static List<Map<String,String>> getSearchResult(String fieldsString , String tablesString, String conditionsString, String orderString, String order, String[] fields) throws Exception {
        String sql = "SELECT DISTINCT "+fieldsString+" FROM "+tablesString+" WHERE ("+conditionsString+") "+order; 
        if (order.equals("")) 
            sql += orderString;
        Session session = getSession();
        NativeQuery sqlQuery = session.createSQLQuery(sql);
        List<Object[]> rows = sqlQuery.getResultList();
        //return var
        List<Map<String,String>> ret = new ArrayList<Map<String,String>>();
        //loop over the rows
        for(Object[] row : rows){         
            //convert the fields from the row to a map
            Map<String, String> fieldVal = new HashMap<String, String>();
            for(int i = 0; i < fields.length; i++){
                String[] name = fields[i].split(" AS ");
                if(name.length == 2)
                    fields[i] = name[1];
                if(row[i] != null)
                    fieldVal.put(fields[i].trim(), row[i].toString());
            }
            ret.add(fieldVal);
        }
        
        return ret;
    }
    
    public static List<Object[]> getSearchCount(String conditionsString, String countString, String tablesString) throws Exception {        
        List<Object[]> ret = new ArrayList<>();
        String sql = "SELECT "+countString+" FROM "+tablesString+" WHERE ("+conditionsString+")";        
        Session session = getSession();
        NativeQuery sqlQuery = session.createSQLQuery(sql);
        List rows = sqlQuery.list();
        
        for (Object object : rows) {
            //if object is not an array, cast it to a one dim array
            if (!object.getClass().isArray()) {
                Object[] arr = new Object[1];
                arr[0] = object;
                ret.add(arr);
                return ret;
            }else{
                ret.add((Object[]) object);
            }
        }
        return ret;
    }
}
