package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class NamenKommentarDB extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<NamenKommentar> criteria = builder.createQuery(NamenKommentar.class);
        Root lit = criteria.from(NamenKommentar.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListBearbeiter() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<NamenKommentarBearbeiter> criteria = builder.createQuery(NamenKommentarBearbeiter.class);
        Root root = criteria.from(NamenKommentarBearbeiter.class);
        criteria.select(root);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListKorrektor() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<NamenKommentarKorrektor> criteria = builder.createQuery(NamenKommentarKorrektor.class);
        Root root = criteria.from(NamenKommentarKorrektor.class);
        criteria.select(root);
        return session.createQuery(criteria).getResultList();
    }
}
