package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class EinzelbelegDB extends AbstractBase {

    public static Einzelbeleg getById(int id) throws Exception {
        return AbstractBase.getById(id, Einzelbeleg.class);
    }

    public static List getList() throws Exception {
        return getList(Einzelbeleg.class);
    }

    public static List getListFunktion() throws Exception {
        return getList(EinzelbelegHatFunktion_MM.class);
    }

    public static List getListTextKritik() throws Exception {
        return getList(EinzelbelegTextkritik.class);
    }

    public static Einzelbeleg getFirstPublicEinzelbeleg() throws Exception {
        try (Session session = getSession()) {
            String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
            Query query = session.createQuery(HQL).setMaxResults(1);
            Einzelbeleg einzelbeleg = (Einzelbeleg) query.getSingleResult();
            return einzelbeleg;
        }
    }

    public static void insertBySql(String sql) throws Exception {
        insertOrUpdate(sql);
    }
    
    public static int countEinzelbelegByQuelleId(int qId) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Einzelbeleg> criteria = builder.createQuery(Einzelbeleg.class);
            Root einzelbeleg = criteria.from(Einzelbeleg.class);
            criteria.select(einzelbeleg);
            criteria.where(builder.equal(einzelbeleg.get(Einzelbeleg_.ID), qId));
            List<Einzelbeleg> res = session.createQuery(criteria).getResultList();
            return res.size();
        }
    }
}
