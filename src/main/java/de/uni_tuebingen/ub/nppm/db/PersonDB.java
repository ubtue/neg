package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class PersonDB extends AbstractBase {

    public static List getListPerson() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Person> criteria = builder.createQuery(Person.class);
        Root lit = criteria.from(Person.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListPersonAmtStandWeihe() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<PersonAmtStandWeihe_MM> criteria = builder.createQuery(PersonAmtStandWeihe_MM.class);
        Root lit = criteria.from(PersonAmtStandWeihe_MM.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListPersonQuiet() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<PersonQuiet> criteria = builder.createQuery(PersonQuiet.class);
        Root lit = criteria.from(PersonQuiet.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
    
    public static List getListPersonVariante() throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<PersonVariante> criteria = builder.createQuery(PersonVariante.class);
        Root lit = criteria.from(PersonVariante.class);
        criteria.select(lit);
        return session.createQuery(criteria).getResultList();
    }
}
