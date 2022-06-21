package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class MghLemmaDB extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<MghLemma> criteria = builder.createQuery(MghLemma.class);
        Root lit = criteria.from(MghLemma.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListBearbeiter() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<MghLemmaBearbeiter> criteria = builder.createQuery(MghLemmaBearbeiter.class);
        Root root = criteria.from(MghLemmaBearbeiter.class);
        criteria.select(root);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListKorrektor() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<MghLemmaKorrektor> criteria = builder.createQuery(MghLemmaKorrektor.class);
        Root root = criteria.from(MghLemmaKorrektor.class);
        criteria.select(root);
        return session.createQuery(criteria).getResultList();
    }
}
