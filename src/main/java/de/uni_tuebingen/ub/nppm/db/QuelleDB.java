package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class QuelleDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Quelle.class);
    }

    public static Quelle getFirstPublicQuelle() throws Exception {

        Session session = getSession();

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Quelle> criteria = criteriaBuilder.createQuery(Quelle.class);
            Root<Quelle> quelle = criteria.from(Quelle.class);

            criteria.select(quelle).where(criteriaBuilder.equal(quelle.get("zuVeroeffentlichen"), 1));

            Quelle un = new Quelle();
            Query query = session.createQuery(criteria);
            un = (Quelle) query.setMaxResults(1).uniqueResult();
            return un;
        } finally {
            session.close();
        }
    }
}

