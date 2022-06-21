package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class LiteraturDB extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Literatur> criteria = builder.createQuery(Literatur.class);
        Root lit = criteria.from(Literatur.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
}
