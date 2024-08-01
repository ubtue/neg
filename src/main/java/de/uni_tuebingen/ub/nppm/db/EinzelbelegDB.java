package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
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

    //Neu Dazu gekommen -- Lemma
    public static boolean hasZusatzNamenKommentar(String lastID) throws Exception {
        try ( Session session = getSession()) {
            String SQL = "SELECT * FROM einzelbeleg_hatnamenkommentar WHERE EinzelbelegID = :lastID";

            if (session.createNativeQuery(SQL) != null) {
                NativeQuery query = session.createNativeQuery(SQL);
                query.setParameter("lastID", lastID);
                return !query.getResultList().isEmpty();
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean hasLemmar(String lastID) throws Exception {
        try ( Session session = getSession()) {
            String SQL = "SELECT * FROM einzelbeleg_hatmghlemma WHERE EinzelbelegID = :lastID";

            if (session.createNativeQuery(SQL) != null) {
                NativeQuery query = session.createNativeQuery(SQL);
                query.setParameter("lastID", lastID);
                return !query.getResultList().isEmpty();
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    //gibt eine Liste von Einzelbelege die die gleiche Belegform haben
    public static List<Einzelbeleg> getBelegformList(String belegform) {
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
}
