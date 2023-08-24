package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.*;
import org.hibernate.query.Query;

public class SelektionQuellengattungDB extends AbstractBase {

    public static void putToDatabase(SelektionQuellengattung quelle) throws Exception {
        try ( Session session = getSession()) {
            session.beginTransaction();
            session.save(quelle);
            session.getTransaction().commit();
        }

    }

    public static List<SelektionQuellengattung> getAllQuellen() throws Exception {
        try ( Session session = getSession()) {
            Query<SelektionQuellengattung> query = session.createQuery("FROM SelektionQuellengattung", SelektionQuellengattung.class);
            List<SelektionQuellengattung> quellen = query.getResultList();
            return quellen;
        }
    }

    //updateParentId(nodeId, newParentId)
    public static void updateParentId(Integer nodeId, Integer newParentId) throws Exception {
        try ( Session session = getSession()) {
            session.beginTransaction();

            // Hole das Monster mit der angegebenen nodeId aus der Datenbank
            SelektionQuellengattung quellenToUpdate = session.get(SelektionQuellengattung.class, nodeId);

            if (quellenToUpdate != null) {

                quellenToUpdate.setParentId(newParentId);
                session.update(quellenToUpdate);
                session.getTransaction().commit();
            }
        }
    }
}//end Class
