package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class SucheDB extends AbstractBase {

    public static List getFavoriten() throws Exception {
        return getList(SucheFavoriten.class);
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
