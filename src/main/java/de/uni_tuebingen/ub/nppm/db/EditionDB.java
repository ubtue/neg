package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;

public class EditionDB extends AbstractBase {
    
    public static Edition getById(int id) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Edition> criteria = builder.createQuery(Edition.class);
            Root edition = criteria.from(Edition.class);
            criteria.select(edition);
            criteria.where(builder.equal(edition.get(Edition_.ID), id));
            Edition res = session.createQuery(criteria).getSingleResult();
            return res;
        }
    }
    
    public static List getList() throws Exception {
        return getList(Edition.class);
    }
}
