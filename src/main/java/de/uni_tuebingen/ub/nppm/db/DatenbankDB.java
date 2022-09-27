package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.*;
import javax.persistence.criteria.*;

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

    public static String getFilterSql(String formular, Integer filterNumber) throws Exception {
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
        DatenbankFilter item = (DatenbankFilter) query.getSingleResult();
        if (item != null) {
            return item.getSqlString();
        }

        return null;
    }

    public static String getLabel(String language, String formular, String textfeld) throws Exception {
        Session session = getSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<DatenbankTexte> criteria = criteriaBuilder.createQuery(DatenbankTexte.class);
        Root<DatenbankTexte> root = criteria.from(DatenbankTexte.class);
        criteria.select(root).where(
                criteriaBuilder.and(
                        criteriaBuilder.equal(root.get("textfeld"), textfeld),
                        criteriaBuilder.equal(root.get("formular"), formular)
                )
        );
        Query query = session.createQuery(criteria);
        DatenbankTexte item = (DatenbankTexte) query.getSingleResult();
        if (item != null) {
            return item.getDe();
        }

        return null;
    }

    public static DatenbankMapping getMapping(String formular, String datafield) throws Exception {
        Session session = getSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<DatenbankMapping> criteria = criteriaBuilder.createQuery(DatenbankMapping.class);
        Root<DatenbankMapping> root = criteria.from(DatenbankMapping.class);
        criteria.select(root).where(
                criteriaBuilder.and(
                        criteriaBuilder.equal(root.get("datenfeld"), datafield),
                        criteriaBuilder.equal(root.get("formular"), formular)
                )
        );
        Query query = session.createQuery(criteria);
        Object item = query.getSingleResult();
        if (item == null) {
            return null;
        }
        return (DatenbankMapping)item;
    }

    public static String getMapping(String lang, String formular, String datafield) throws Exception {
        DatenbankMapping mapping = getMapping(formular, datafield);
        if (mapping != null) {
            return mapping.getDeBeschriftung();
        }

        return null;
    }

    public static Object getSingleResult(String sql) throws Exception {
        Session session = getSession();
        SQLQuery query = session.createSQLQuery(sql);
        List<Object> rows = query.getResultList();
        if(rows.size() > 0)
            return rows.get(0);
        else
            return null;
    }

}