package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class EditionDB extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Edition> criteria = builder.createQuery(Edition.class);
        Root edition = criteria.from(Edition.class);
        criteria.select(edition);
        return session.createQuery(criteria).getResultList();
    }
}
