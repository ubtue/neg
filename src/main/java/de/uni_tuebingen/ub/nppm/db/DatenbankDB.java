package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.*;
import javax.persistence.criteria.*;
import javax.servlet.jsp.JspWriter;

public class DatenbankDB extends AbstractBase {

    public static List getListFilter() throws Exception {
        return getList(DatenbankFilter.class);
    }
    
    public static List getListMapping() throws Exception {
        return getList(DatenbankMapping.class);
    }
    
    public static List getListSelektion() throws Exception {
        return getList(DatenbankSelektion.class);
    }
    
    public static List getListSprache() throws Exception {
        return getList(DatenbankSprache.class);
    }
    
    public static List getListTexte() throws Exception {
        return getList(DatenbankTexte.class);
    }
    
    public static String getFilterSql(String formular, Integer filterNumber){
        try {
            Session session = getSession();
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<DatenbankFilter> criteria = criteriaBuilder.createQuery(DatenbankFilter.class);
            Root<DatenbankFilter> root = criteria.from(DatenbankFilter.class);
            criteria.select(root).where(
                    criteriaBuilder.and(
                        criteriaBuilder.equal(root.get("nummer"), filterNumber),
                        criteriaBuilder.equal(root.get("formular"), formular)    
                    )
            );
            Query query = session.createQuery(criteria);
            DatenbankFilter item = (DatenbankFilter)query.getSingleResult();            
            if(item != null){
                return item.getSqlString();
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return null;
    }
    
    
}