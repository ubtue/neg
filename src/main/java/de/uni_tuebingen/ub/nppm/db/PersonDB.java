package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.IOException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.jsp.JspWriter;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

public class PersonDB extends AbstractBase {

    public static List getListPerson() throws Exception {
        return getList(Person.class);
    }

    public static List getListPersonAmtStandWeihe() throws Exception {
        return getList(PersonAmtStandWeihe_MM.class);
    }

    public static List getListPersonQuiet() throws Exception {
        return getList(PersonQuiet.class);
    }

    public static List getListPersonVariante() throws Exception {
        return getList(PersonVariante.class);
    }

     public static Person getFirstPublicPerson() throws Exception, Exception {

        Session session = getSession();
        String SQL = "SELECT * FROM person WHERE ID IN (SELECT PersonID FROM einzelbeleg_hatperson WHERE EinzelbelegID IN (SELECT einzelbeleg.id FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1))ORDER BY id ASC";

        NativeQuery query = session.createSQLQuery(SQL);
        query.addEntity(Person.class);
        query.setMaxResults(1);
        return (Person)query.getSingleResult();
    }
}