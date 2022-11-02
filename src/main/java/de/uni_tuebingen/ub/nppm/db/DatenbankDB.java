package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.TypedQuery;
import org.hibernate.*;
import javax.persistence.criteria.*;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.query.NativeQuery;

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
        DatenbankTexte item = getLabel(formular, textfeld);

        if (item != null) {
            return item.get(language);
        }

        return null;
    }

    public static DatenbankTexte getLabel(String formular, String textfeld) throws Exception {
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
        List<Object> rows = query.getResultList();
        if (rows.isEmpty()) {
            return null;
        }
        return (DatenbankTexte) rows.get(0);
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
        List<Object> rows = query.getResultList();
        if (rows.isEmpty()) {
            return null;
        }
        return (DatenbankMapping) rows.get(0);
    }


    public static String getMapping(String lang, String formular, String datafield) throws Exception {
        DatenbankMapping mapping = getMapping(formular, datafield);
        if (mapping != null) {
            return mapping.getBeschriftung(lang);
        }

        return null;
    }

    public static Object getSingleResult(String sql) throws Exception {
        Session session = getSession();
        SQLQuery query = session.createSQLQuery(sql);
        List<Object> rows = query.getResultList();
        if (rows.size() > 0) {
            return rows.get(0);
        } else {
            return null;
        }
    }
    
    public static List<Object> getSelektion() throws Exception, Exception {
        Session session = getSession();
        String SQL = "SELECT DISTINCT selektion FROM datenbank_selektion ORDER BY selektion ASC";
        NativeQuery query = session.createSQLQuery(SQL);
        List<Object> rows = query.getResultList();
        return rows;
    }
    
    public static List<Object> getBezeichnung(String tabelle, String bezeichnung) throws Exception {
        Session session = getSession();
        String SQL = "SELECT Bezeichnung FROM selektion_"+tabelle +" where Bezeichnung='"+bezeichnung+"'";
        NativeQuery query = session.createSQLQuery(SQL);
        List<Object> rows = query.getResultList();
        return rows;
    }
    
    public static void insertBezeichnung(String tabelle, String bezeichnung, Integer id) throws Exception {
        Session session = getSession();
        String SQL = "INSERT INTO selektion_"+tabelle+" (ID, Bezeichnung) VALUES ("+id+", \""+bezeichnung+"\")";
        session.getTransaction().begin();
        NativeQuery query = session.createSQLQuery(SQL);
        query.executeUpdate();
        session.getTransaction().commit();
    }
    
    public static void updateBezeichnung(String tabelle, String bezeichnung, String id) throws Exception {
        Session session = getSession();
        String SQL = "UPDATE selektion_"+tabelle
                        +" SET Bezeichnung=\""+bezeichnung+"\""
                        +" WHERE ID="+id;
        session.getTransaction().begin();
        NativeQuery query = session.createSQLQuery(SQL);
        query.executeUpdate();
        session.getTransaction().commit();
    }
    
    public static Integer getMaxId(String tabelle) throws Exception {
        return (Integer)DatenbankDB.getSingleResult("SELECT max(ID) max FROM selektion_"+tabelle);
    }
    
    public static void updateAuswahlfelder(String tabelle, String feldAlt, String feldNeu) throws Exception {
        Session session = getSession();        
        String SQL = "SELECT tabelle, spalte FROM datenbank_selektion WHERE selektion ='"+tabelle+"';";
        NativeQuery query = session.createSQLQuery(SQL);
        List<Object[]> rows = query.getResultList();
        for(Object[] row : rows){
            String tbl = row[0].toString();
            String col = row[1].toString();
            String updateSQL = "UPDATE "+tbl+" SET "+col+"="+feldNeu
                     + " WHERE "+col+"="+feldAlt+";";
            session.getTransaction().begin();
            NativeQuery update = session.createSQLQuery(updateSQL);
            update.executeUpdate();
            session.getTransaction().commit();
        }
        
    }
    
    public static void deleteAuswahlfeld(String tabelle, String feldAlt) throws Exception {
        Session session = getSession();
        String SQL = "DELETE FROM "+tabelle
                      + " WHERE ID="+feldAlt;
        session.getTransaction().begin();
        NativeQuery query = session.createSQLQuery(SQL);
        query.executeUpdate();
        session.getTransaction().commit();
    }
}
