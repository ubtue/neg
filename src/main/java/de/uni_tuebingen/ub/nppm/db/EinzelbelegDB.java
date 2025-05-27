package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;
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
        try (Session session = getSession()) {
            String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
            Query query = session.createQuery(HQL).setMaxResults(1);
            Einzelbeleg einzelbeleg = (Einzelbeleg) query.getSingleResult();
            return einzelbeleg;
        }
    }

    /**
     * Liefert ein Predicate, das alle Einzelbelege ausschließt, die mit
     * mindestens einem MghLemma verknüpft sind, dessen Text den Substring
     * "[???]" enthält.
     *
     * @param root die Root-Entität Einzelbeleg
     * @param cb der CriteriaBuilder
     * @param query die umgebende CriteriaQuery (oder Subquery)
     * @return ein Predicate, das NOT EXISTS (Subquery) umsetzt
     */
    private static Predicate excludeInvalidLemmas(Root<Einzelbeleg> root,
            CriteriaBuilder cb,
            CriteriaQuery<?> query) {
        Subquery<Integer> sq = query.subquery(Integer.class);
        Root<Einzelbeleg> subRoot = sq.correlate(root);
        Join<Einzelbeleg, MghLemma> jm = subRoot.join("mghLemma");
        sq.select(subRoot.get("id"))
                .where(cb.like(jm.get("mghLemma"), "%[???]%"));
        return cb.not(cb.exists(sq));
    }

    public static Integer getNextPublicEinzelbeleg(int id) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

            // 1. Die kleinste und größte veröffentlichte ID holen
            CriteriaQuery<Object[]> boundsQuery = criteriaBuilder.createQuery(Object[].class);
            Root<Einzelbeleg> boundRoot = boundsQuery.from(Einzelbeleg.class);
            boundsQuery.multiselect(
                    criteriaBuilder.min(boundRoot.get("id")),
                    criteriaBuilder.max(boundRoot.get("id"))
            ).where(criteriaBuilder.equal(boundRoot.get("quelle").get("zuVeroeffentlichen"), 1),
                    excludeInvalidLemmas(boundRoot, criteriaBuilder, boundsQuery)
            );

            Query<Object[]> boundsQueryResult = session.createQuery(boundsQuery);
            Object[] boundsResult = boundsQueryResult.uniqueResult();
            Integer minId = (Integer) boundsResult[0];
            Integer maxId = (Integer) boundsResult[1];

            // Wenn keine öffentlichen Einzelbelege existieren, gib null zurück
            if (minId == null || maxId == null) {
                return null;
            }

            // 2. Prüfen, ob die ID ungültig oder negativ ist
            if (id < 0) {
                return minId;  // Wenn ID ungültig oder negativ ist, gebe die kleinste public ID zurück
            }

            // 3. Prüfen, ob die ID kleiner als die kleinste public ID ist
            if (id < minId) {
                return minId;  // ID ist kleiner als die kleinste public ID, daher gebe die kleinste zurück
            }

            // 4. Prüfen, ob die ID größer als die größte public ID ist
            if (id > maxId) {
                return maxId;  // ID ist größer als die größte public ID, daher gebe die größte zurück
            }

            // 5. Prüfen, ob die übergebene ID veröffentlicht ist
            CriteriaQuery<Integer> criteriaQuery = criteriaBuilder.createQuery(Integer.class);
            Root<Einzelbeleg> root = criteriaQuery.from(Einzelbeleg.class);
            criteriaQuery.select(root.get("id"))
                    .where(
                            criteriaBuilder.equal(root.get("id"), id),
                            criteriaBuilder.equal(root.get("quelle").get("zuVeroeffentlichen"), 1),
                            excludeInvalidLemmas(root, criteriaBuilder, criteriaQuery)
                    );

            Query<Integer> query = session.createQuery(criteriaQuery);
            Integer resultId = query.uniqueResult();

            // 6. Wenn die ID veröffentlicht ist, gebe sie zurück
            if (resultId != null) {
                return resultId;
            }

            // 7. Wenn die ID nicht veröffentlicht ist, suche die nächste veröffentlichte ID
            CriteriaQuery<Integer> nextCriteriaQuery = criteriaBuilder.createQuery(Integer.class);
            Root<Einzelbeleg> nextRoot = nextCriteriaQuery.from(Einzelbeleg.class);
            nextCriteriaQuery.select(nextRoot.get("id"))
                    .where(
                            criteriaBuilder.greaterThan(nextRoot.get("id"), id),
                            criteriaBuilder.equal(nextRoot.get("quelle").get("zuVeroeffentlichen"), 1),
                            excludeInvalidLemmas(nextRoot, criteriaBuilder, nextCriteriaQuery)
                    )
                    .orderBy(criteriaBuilder.asc(nextRoot.get("id")));

            Query<Integer> nextQuery = session.createQuery(nextCriteriaQuery);
            nextQuery.setMaxResults(1);  // Nur das nächste Ergebnis zurückgeben

            // 8. Die ID des nächsten veröffentlichten Einzelbelegs zurückgeben
            Integer nextId = nextQuery.uniqueResult();
            return nextId != null ? nextId : maxId;  // Falls keine ID gefunden wurde, gebe die größte public ID zurück
        }
    }

    public static void insertBySql(String sql) throws Exception {
        insertOrUpdate(sql);
    }

    //gibt eine Liste von Einzelbelege die die gleiche Belegform haben
    public static List<Einzelbeleg> getListByBelegform(String belegform) {
        try (Session session = getSession()) {
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
        try (Session session = getSession()) {
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
        try (Session session = getSession()) {
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
        try (Session session = getSession()) {
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

    public static List<Integer> getAllPublicEinzelbelegIds() throws Exception {
        try (Session session = getSession()) {
            /*
                Exclude Einzelbelege that are linked to a MGHLemma which contains [???0 in Frontend]
            */
            String sql = "SELECT e.ID "
                    + "FROM einzelbeleg e "
                    + "  JOIN quelle q ON e.QuelleID = q.ID AND q.zuVeroeffentlichen = 1 "
                    + "  LEFT JOIN einzelbeleg_hatmghlemma eh ON eh.EinzelbelegID = e.ID "
                    + "  LEFT JOIN mgh_lemma m ON m.ID = eh.MGHLemmaID AND m.MGHLemma LIKE '%[???]%' "
                    + "WHERE m.ID IS NULL "
                    + "ORDER BY e.ID";
            return session.createNativeQuery(sql).getResultList();
        }
    }
}
