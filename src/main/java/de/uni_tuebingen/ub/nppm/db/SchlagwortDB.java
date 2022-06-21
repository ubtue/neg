package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class SchlagwortDB extends AbstractBase {

    public static List getListArealgens() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SchlagwortArealgens> criteria = builder.createQuery(SchlagwortArealgens.class);
        Root lit = criteria.from(SchlagwortArealgens.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListMorphologie() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SchlagwortMorphologie> criteria = builder.createQuery(SchlagwortMorphologie.class);
        Root lit = criteria.from(SchlagwortMorphologie.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListMotivation() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SchlagwortMotivation> criteria = builder.createQuery(SchlagwortMotivation.class);
        Root lit = criteria.from(SchlagwortMotivation.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListNamenLexikon() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SchlagwortNamenLexikon> criteria = builder.createQuery(SchlagwortNamenLexikon.class);
        Root lit = criteria.from(SchlagwortNamenLexikon.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListPhongraph() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SchlagwortPhongraph> criteria = builder.createQuery(SchlagwortPhongraph.class);
        Root lit = criteria.from(SchlagwortPhongraph.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListSprachherkunft() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SchlagwortSprachherkunft> criteria = builder.createQuery(SchlagwortSprachherkunft.class);
        Root lit = criteria.from(SchlagwortSprachherkunft.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
}
