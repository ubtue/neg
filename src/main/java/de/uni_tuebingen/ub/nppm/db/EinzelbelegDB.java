package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

public class EinzelbelegDB extends AbstractBase{

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
        try ( Session session = getSession()) {
            String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
            Query query = session.createQuery(HQL).setMaxResults(1);
            Einzelbeleg einzelbeleg = (Einzelbeleg) query.getSingleResult();
            return einzelbeleg;
        }
    }

    public static void insertBySql(String sql) throws Exception {
        insertOrUpdate(sql);
    }

    //gibt eine Liste von Einzelbelege die die gleiche Belegform haben
    public static List<Einzelbeleg> getListByBelegform(String belegform) {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Einzelbeleg> criteria = builder.createQuery(Einzelbeleg.class);
            Root<Einzelbeleg> root = criteria.from(Einzelbeleg.class);

            criteria.select(root)
                    .where(builder.equal(root.get("belegform"), belegform));

            Query<Einzelbeleg> query = session.createQuery(criteria);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving Einzelbeleg list by belegform: " + belegform, e);
        }
    }

     public static void insertLemma(String einzelbelegId, String mghLemmaId) throws Exception {
        String sql = "INSERT INTO einzelbeleg_hatmghlemma(EinzelbelegID, MGHLemmaID) VALUES(" + einzelbelegId + ", " + mghLemmaId + ")";
        insertOrUpdate(sql);
    }

    public static void insertNamenkommentar(String einzelbelegId, String namenkommentarId) throws Exception {
        String sql = "INSERT INTO einzelbeleg_hatnamenkommentar(EinzelbelegID, NamenkommentarID) VALUES(" + einzelbelegId + ", " + namenkommentarId + ")";
        insertOrUpdate(sql);
    }

    public static void insertFunktion(String einzelbelegId, String funktionID) throws Exception {
        String sql = "INSERT INTO einzelbeleg_hatfunktion(EinzelbelegID, FunktionID) VALUES(" + einzelbelegId + ", " + funktionID + ")";
        insertOrUpdate(sql);
    }

    public static List<EinzelbelegHatFunktion_MM> getListEinzelbelegHatFunktion(int funktionId) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<EinzelbelegHatFunktion_MM> query = builder.createQuery(EinzelbelegHatFunktion_MM.class);
            Root<EinzelbelegHatFunktion_MM> root = query.from(EinzelbelegHatFunktion_MM.class);

            query.select(root);
            // Erstelle ein Predicate für das FunktionID-Feld
            Predicate functionIdPredicate = builder.equal(root.get("funktion").get("id"), funktionId);
            query.where(functionIdPredicate);

            return session.createQuery(query).getResultList();
        }
    }

    public static List<EinzelbelegHatAmtWeihe_MM> getListEinzelbelegHatAmtWeihe(int einzelbelegId) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<EinzelbelegHatAmtWeihe_MM> query = builder.createQuery(EinzelbelegHatAmtWeihe_MM.class);
            Root<EinzelbelegHatAmtWeihe_MM> root = query.from(EinzelbelegHatAmtWeihe_MM.class);

            query.select(root);
            // Erstelle ein Predicate für das FunktionID-Feld
            Predicate functionIdPredicate = builder.equal(root.get("einzelbeleg").get("id"), einzelbelegId);
            query.where(functionIdPredicate);

            return session.createQuery(query).getResultList();
        }
    }

    public static List<EinzelbelegHatStand> getListEinzelbelegHatStand(int einzelbelegId) throws Exception {
        try ( Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<EinzelbelegHatStand> query = builder.createQuery(EinzelbelegHatStand.class);
            Root<EinzelbelegHatStand> root = query.from(EinzelbelegHatStand.class);

            query.select(root);
            // Erstelle ein Predicate für das FunktionID-Feld
            Predicate functionIdPredicate = builder.equal(root.get("einzelbeleg").get("id"), einzelbelegId);
            query.where(functionIdPredicate);

            return session.createQuery(query).getResultList();
        }
    }
}
