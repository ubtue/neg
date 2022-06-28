package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class HandschriftDB extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Handschrift> criteria = builder.createQuery(Handschrift.class);
        Root edition = criteria.from(Handschrift.class);
        criteria.select(edition);
        return session.createQuery(criteria).getResultList();
    }
}
