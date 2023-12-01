package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import de.uni_tuebingen.ub.nppm.model.Content.Context;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class QuelleDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Quelle.class);
    }

    public static List getList(Integer currentPage, Integer recordsPerPage, String filterTitle) throws Exception {
        Integer start = null;
        if(currentPage != null && recordsPerPage != null)
            start = currentPage * recordsPerPage - recordsPerPage;
        
        try (Session session = getSession()) {
            Query query = session.createQuery("from Quelle q where q.bezeichnung like :bez");
            query.setFirstResult(start);
            query.setMaxResults(recordsPerPage);
            query.setParameter("bez", "%" + filterTitle + "%");
            return query.list();
        }
    }
        
    public static Long countStat(String filterTitle) throws Exception {
        try (Session session = getSession()) {
            Query query = session.createQuery("select count(*) from Quelle q where q.bezeichnung like :bez");            
            query.setParameter("bez", "%" + filterTitle + "%");
            return (Long)query.uniqueResult();
        }
    }

    public static Quelle getFirstPublicQuelle() throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Quelle> criteria = criteriaBuilder.createQuery(Quelle.class);
            Root<Quelle> quelle = criteria.from(Quelle.class);

            criteria.select(quelle).where(criteriaBuilder.equal(quelle.get("zuVeroeffentlichen"), 1));

            Query query = session.createQuery(criteria);
            return (Quelle)query.setMaxResults(1).uniqueResult();
        }
    }

     public static Quelle getById(int id) throws Exception {
        return AbstractBase.getById(id, Quelle.class);
    }


     public static List<Quelle> searchByFileName(String filename,  Context fileType) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Quelle> criteria = builder.createQuery(Quelle.class);
            Root quelle = criteria.from(Quelle.class);
            criteria.select(quelle);
            if(fileType == Context.QUELLENKOMMENTAR)
            {
                criteria.where(builder.equal( quelle.get(Quelle_.QUELLEN_KOMMENTAR_DATEI), filename));
            }
            else if(fileType == Context.UEBERLIEFERUNGSKOMMENTAR)
            {
                 criteria.where(builder.equal( quelle.get(Quelle_.UEBERLIEFERUNGS_KOMMENTAR_DATEI), filename));
            }

            List<Quelle> res = session.createQuery(criteria).getResultList();
            return res;
        }
    }

      public static void saveOrUpdate(Quelle quelle) throws Exception {
        try (Session session = getSession()) {
            session.getTransaction().begin();
            session.saveOrUpdate(quelle);
            session.getTransaction().commit();
        }
    }


}//end Class
