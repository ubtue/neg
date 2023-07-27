package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

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
        try (Session session = getSession()) {
            String SQL = "SELECT * FROM person WHERE ID IN (SELECT PersonID FROM einzelbeleg_hatperson WHERE EinzelbelegID IN (SELECT einzelbeleg.id FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1))ORDER BY id ASC";

            NativeQuery query = session.createNativeQuery(SQL);
            query.addEntity(Person.class);
            query.setMaxResults(1);
            return (Person) query.getSingleResult();
        }
    }
}
