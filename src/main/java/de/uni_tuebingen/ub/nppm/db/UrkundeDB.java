package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;

public class UrkundeDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Urkunde.class);
    }


     public static Urkunde getUrkunde(int quellenId) throws Exception {

        Session session = getSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Urkunde> criteria = criteriaBuilder.createQuery(Urkunde.class);
        Root<Urkunde> urkunde = criteria.from(Urkunde.class);

        criteria.select(urkunde).where(criteriaBuilder.equal(urkunde.get("quelle"), quellenId));

        TypedQuery<Urkunde> typedQuery = session.createQuery(criteria);
        Urkunde un = typedQuery.getSingleResult();

         return un;
    }
}
