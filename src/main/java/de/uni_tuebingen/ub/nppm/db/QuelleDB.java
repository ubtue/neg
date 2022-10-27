package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class QuelleDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Quelle.class);
    }

    public static int getFirstPublicQuelle(int quellenId) throws Exception {

        Session session = getSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Quelle> criteria = criteriaBuilder.createQuery(Quelle.class);
        Root<Quelle> q = criteria.from(Quelle.class);
        criteria.select(q).where(
                criteriaBuilder.and(
                       // criteriaBuilder.equal(urkunde.get("QuelleID"), id)  //funktioniert nicht findet "QuelleID" nicht
                        criteriaBuilder.equal(q.get("id"), quellenId)
                )
        );

        TypedQuery<Quelle> typedQuery = session.createQuery(criteria);
        Quelle un = typedQuery.getSingleResult();

         return un.getId();
    }

     public static int getFirstPublicUrkundeId(int quellenId) throws Exception {

        Session session = getSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Urkunde> criteria = criteriaBuilder.createQuery(Urkunde.class);
        Root<Urkunde> urkunde = criteria.from(Urkunde.class);
        criteria.select(urkunde).where(
                criteriaBuilder.and(
                       // criteriaBuilder.equal(urkunde.get("QuelleID"), id)  //funktioniert nicht findet "QuelleID" nicht
                        criteriaBuilder.equal(urkunde.get("quelle"), quellenId)
                )
        );

        TypedQuery<Urkunde> typedQuery = session.createQuery(criteria);
        Urkunde un = new Urkunde();
        un = typedQuery.getSingleResult();

         return un.getId();
    }
}

