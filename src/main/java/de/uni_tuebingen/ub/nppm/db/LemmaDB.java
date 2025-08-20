package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import de.uni_tuebingen.ub.nppm.util.Constants;
import de.uni_tuebingen.ub.nppm.util.pagination.statistics.PaginationParams;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

public class LemmaDB extends AbstractBase {
    public static final String SUBSELECT_PUBLIC_MGHLEMMA_IDS = "SELECT DISTINCT MGHLemmaID FROM einzelbeleg_hatmghlemma WHERE EinzelbelegID IN (" + EinzelbelegDB.SUBSELECT_PUBLIC_EINZELBELEG_IDS + ")";

    public static MghLemma getById(int id) throws Exception {
        return AbstractBase.getById(id, MghLemma.class);
    }

    public static List<MghLemma> getList() throws Exception {
        return getList(MghLemma.class);
    }

    public static List<MghLemma> getListPublic() throws Exception {
        try (Session session = getSession()) {
            String sql = "SELECT * FROM mgh_lemma WHERE ID IN (SELECT MGHLemmaID FROM einzelbeleg_hatmghlemma ehm JOIN einzelbeleg e ON e.ID = ehm.EinzelbelegID JOIN quelle q ON q.ID = e.QuelleID WHERE q.ZuVeroeffentlichen = 1)";

            NativeQuery query = session.createNativeQuery(sql);
            query.addEntity(MghLemma.class);
            return query.getResultList();
        }
    }

    public static List<MghLemmaBearbeiter> getListBearbeiter() throws Exception {
        return getList(MghLemmaBearbeiter.class);
    }

    public static List<MghLemmaKorrektor> getListKorrektor() throws Exception {
        return getList(MghLemmaKorrektor.class);
    }

    public static MghLemma getFirstPublicMGHLemma() throws Exception {
        try (Session session = getSession()) {
            String SQL = "SELECT * FROM mgh_lemma WHERE mgh_lemma.ID in (SELECT n.ID FROM einzelbeleg e, quelle q, einzelbeleg_hatmghlemma h, mgh_lemma n WHERE e.ID=h.einzelbelegID and n.ID=h.MGHLemmaID and e.QuelleID=q.ID AND q.ZuVeroeffentlichen=1) ORDER BY id ASC";
            NativeQuery query = session.createNativeQuery(SQL);
            query.addEntity(MghLemma.class);
            query.setMaxResults(1);
            return (MghLemma) query.getSingleResult();
        }
    }

    public static Integer getNextPublicMGHLemmaID(int id) throws Exception {
        try (Session session = getSession()) {
            String sql
                    = "SELECT "
                    + "  CASE "
                    + "    WHEN :id < minId THEN minId "
                    + "    WHEN :id > maxId THEN maxId "
                    + "    WHEN EXISTS ( "
                    + "      SELECT 1 FROM mgh_lemma "
                    + "      JOIN einzelbeleg_hatmghlemma h ON mgh_lemma.ID = h.MGHLemmaID "
                    + "      JOIN einzelbeleg e ON e.ID = h.EinzelbelegID "
                    + "      JOIN quelle q ON e.QuelleID = q.ID "
                    + "      WHERE q.ZuVeroeffentlichen = 1 AND mgh_lemma.ID = :id "
                    + "        AND mgh_lemma.MGHLemma NOT LIKE '%"+AbstractBase.escape(Constants.forbiddenLemmaSubstring,sqlEscapesSingleQuotes)+"%' "
                    + "    ) THEN :id "
                    + "    ELSE ( "
                    + "      SELECT MIN(mgh_lemma.ID) "
                    + "      FROM mgh_lemma "
                    + "      JOIN einzelbeleg_hatmghlemma h ON mgh_lemma.ID = h.MGHLemmaID "
                    + "      JOIN einzelbeleg e ON e.ID = h.EinzelbelegID "
                    + "      JOIN quelle q ON e.QuelleID = q.ID "
                    + "      WHERE q.ZuVeroeffentlichen = 1 AND mgh_lemma.ID > :id "
                    + "        AND mgh_lemma.MGHLemma NOT LIKE '%"+AbstractBase.escape(Constants.forbiddenLemmaSubstring,sqlEscapesSingleQuotes)+"%' "
                    + "    ) "
                    + "  END AS resultId "
                    + "FROM ( "
                    + "  SELECT MIN(mgh_lemma.ID) AS minId, MAX(mgh_lemma.ID) AS maxId "
                    + "  FROM mgh_lemma "
                    + "  JOIN einzelbeleg_hatmghlemma h ON mgh_lemma.ID = h.MGHLemmaID "
                    + "  JOIN einzelbeleg e ON e.ID = h.EinzelbelegID "
                    + "  JOIN quelle q ON e.QuelleID = q.ID "
                    + "  WHERE q.ZuVeroeffentlichen = 1 "
                    + "        AND mgh_lemma.MGHLemma NOT LIKE '%"+AbstractBase.escape(Constants.forbiddenLemmaSubstring,sqlEscapesSingleQuotes)+"%' "
                    + ") AS ids";

            NativeQuery query = session.createNativeQuery(sql);
            query.setParameter("id", id);

            Object result = query.uniqueResult();
            return result != null ? ((Number) result).intValue() : null;
        }
    }

    public static List<MghLemma> getByName(String name) throws Exception {
        String sql = "SELECT * FROM mgh_lemma WHERE MGHLemma" + " LIKE '%" + name + "%' ";
        sql += " ORDER BY MGHLemma";

        try (Session session = getSession()) {
            NativeQuery sqlQuery = session.createNativeQuery(sql);
            sqlQuery.addEntity(MghLemma.class);
            List<MghLemma> rows = sqlQuery.getResultList();
            return rows;
        }
    }

    public static List<String> getListErstglied() throws Exception {
        return getStringListNative("SELECT DISTINCT SUBSTRING_INDEX(MGHLemma, '~', 1) AS Erstglied  FROM neg.mgh_lemma WHERE MGHLemma LIKE '%~%' AND MGHLemma NOT LIKE '%"+AbstractBase.escape(Constants.forbiddenLemmaSubstring,sqlEscapesSingleQuotes)+"%' ORDER BY Erstglied ASC");
    }

    public static List<String> getListZweitglied() throws Exception {
        return getStringListNative("SELECT DISTINCT SUBSTRING_INDEX(MGHLemma, '~', -1) AS Zweitglied  FROM neg.mgh_lemma WHERE MGHLemma LIKE '%~%' AND MGHLemma NOT LIKE '%"+AbstractBase.escape(Constants.forbiddenLemmaSubstring,sqlEscapesSingleQuotes)+"%' ORDER BY Zweitglied ASC");
    }

    public static List<MghLemma> getLemmaByBelegform(String belegform) throws Exception {
        String sql = "SELECT DISTINCT ml.* FROM mgh_lemma ml "
                + "JOIN einzelbeleg_hatmghlemma ehm ON ml.ID = ehm.MGHLemmaID "
                + "JOIN einzelbeleg eb ON ehm.EinzelbelegID = eb.ID "
                + "WHERE eb.Belegform = :belegform "
                + "ORDER BY ml.MGHLemma ";

        try (Session session = getSession()) {
            NativeQuery<MghLemma> sqlQuery = session.createNativeQuery(sql, MghLemma.class);
            sqlQuery.setParameter("belegform", belegform);
            List<MghLemma> results = sqlQuery.getResultList();
            return results; // Genau ein Treffer
        }
    }

    public static List<Integer> getAllPublicLemmaIds() throws Exception {
        try (Session session = getSession()) {
            String sql = "SELECT DISTINCT ehm.MGHLemmaID "
                    + "FROM einzelbeleg_hatmghlemma ehm "
                    + "JOIN einzelbeleg e ON e.ID = ehm.EinzelbelegID "
                    + "JOIN quelle q ON q.ID = e.QuelleID "
                    + "JOIN mgh_lemma l ON l.ID = ehm.MGHLemmaID "
                    + // <- hier korrigiert
                    "WHERE q.ZuVeroeffentlichen = 1 "
                    + "ORDER BY ehm.MGHLemmaID";

            return session.createNativeQuery(sql).getResultList();
        }
    }

    public static Long countStat(String filterTitle) throws Exception {
        if (filterTitle == null) {
            filterTitle = "";
        }

        try (Session session = getSession()) {
            String hql = "SELECT COUNT(DISTINCT l.id) "
                    + "FROM MghLemma l "
                    + "JOIN l.einzelbelege e "
                    + "JOIN e.quelle q "
                    + "WHERE q.zuVeroeffentlichen = 1 "
                    + "AND l.mghLemma LIKE :lemma";

            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("lemma", "%" + filterTitle + "%");

            return query.uniqueResult();
        }
    }

    public static long getEinzelbelegeCount(int lemmaId) throws Exception {
        try (Session session = getSession()) {
            String sql = "SELECT COUNT(DISTINCT e.ID) "
                    + "FROM einzelbeleg_hatmghlemma ehm "
                    + "JOIN einzelbeleg e ON e.ID = ehm.EinzelbelegID "
                    + "JOIN quelle q ON q.ID = e.QuelleID "
                    + "WHERE ehm.MGHLemmaID = :lemmaId AND q.ZuVeroeffentlichen = 1";

            Query<?> query = session.createNativeQuery(sql);
            query.setParameter("lemmaId", lemmaId);

            Object result = query.getSingleResult();
            return ((Number) result).longValue();
        }
    }

    public static List<MghLemma> getList(PaginationParams params) throws Exception {
        String jumpToID = params.getJumpToID();
        String sort = params.getSort();
        String filterTitle = params.getFilters().get("filterTitle");
        Integer currentPage = params.getCurrentPage();
        Integer recordsPerPage = params.getRecordsPerPage();

        if (filterTitle == null) {
            filterTitle = "";
        }

        try (Session session = getSession()) {
            if (jumpToID != null && !jumpToID.isEmpty()) {
                // Einzelnes Lemma gezielt per ID holen
                String hql = "FROM MghLemma l WHERE l.id = :id";
                Query<MghLemma> query = session.createQuery(hql, MghLemma.class);
                query.setParameter("id", Integer.valueOf(jumpToID));
                return query.list();
            } else {
                Integer offset = null;
                if (currentPage != null && recordsPerPage != null) {
                    offset = (currentPage - 1) * recordsPerPage;
                }

                String sql;
                if (sort != null && sort.startsWith("title")) {
                    sql = "SELECT DISTINCT l.* "
                            + "FROM mgh_lemma l "
                            + "JOIN einzelbeleg_hatmghlemma ehm ON l.ID = ehm.MGHLemmaID "
                            + "JOIN einzelbeleg e ON e.ID = ehm.EinzelbelegID "
                            + "JOIN quelle q ON q.ID = e.QuelleID "
                            + "WHERE q.ZuVeroeffentlichen = 1 "
                            + "AND l.MGHLemma LIKE :lemma "
                            + "ORDER BY l.MGHLemma " + (sort.equals("titleDown") ? "DESC" : "ASC");

                } else if (sort != null && sort.startsWith("belege")) {
                    sql = "SELECT DISTINCT l.* "
                            + "FROM mgh_lemma l "
                            + "JOIN einzelbeleg_hatmghlemma ehm ON l.ID = ehm.MGHLemmaID "
                            + "JOIN einzelbeleg e ON e.ID = ehm.EinzelbelegID "
                            + "JOIN quelle q ON q.ID = e.QuelleID "
                            + "WHERE q.ZuVeroeffentlichen = 1 "
                            + "AND l.MGHLemma LIKE :lemma "
                            + "GROUP BY l.ID "
                            + "ORDER BY COUNT(e.ID) " + (sort.equals("belegeDown") ? "DESC" : "ASC");

                } else {
                    sql = "SELECT DISTINCT l.* "
                            + "FROM mgh_lemma l "
                            + "JOIN einzelbeleg_hatmghlemma ehm ON l.ID = ehm.MGHLemmaID "
                            + "JOIN einzelbeleg e ON e.ID = ehm.EinzelbelegID "
                            + "JOIN quelle q ON q.ID = e.QuelleID "
                            + "WHERE q.ZuVeroeffentlichen = 1 "
                            + "AND l.MGHLemma LIKE :lemma";
                }

                Query<MghLemma> query = session.createNativeQuery(sql, MghLemma.class);
                query.setParameter("lemma", "%" + filterTitle + "%");

                if (offset != null) {
                    query.setFirstResult(offset);
                    query.setMaxResults(recordsPerPage);
                }

                return query.getResultList();
            }
        }
    }

    public static boolean updateLemma(List<Integer> belegIdList, String lemma) {
        if (belegIdList == null || belegIdList.isEmpty()) {
            return true;
        }
        Transaction tx = null;
        try (Session session = getSession()) {
            tx = session.beginTransaction();

            //Lemma-ID suchen oder anlegen
            Integer lemmaId = getExistingLemma(session, lemma);
            if (lemmaId == null) {
                lemmaId = createNewLemma(session, lemma);
                if (lemmaId == null) {
                    throw new Exception("Error creating lemma");
                }
            }

            //Für jedes Beleg-Id prüfen/verknüpfen/aktualisieren
            for (Integer belegId : belegIdList) {
                Integer linkId = getExistingBelegLemmaLink(session, belegId);
                if (linkId == null) {
                    if (!createNewBelegLemmaLink(session, belegId, lemmaId)) {
                        throw new Exception("Error creating the document-lemma link");
                    }
                } else {
                    if (!updateBelegLemmaLink(session, linkId, lemmaId)) {
                        throw new Exception("Error updating the document-lemma link");
                    }
                }
            }
            tx.commit();
            return true;
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
            return false;
        }
    }

    private static Integer getExistingLemma(Session session, String lemma) {
        Object id = session.createNativeQuery(
                "SELECT id FROM mgh_lemma WHERE CAST(mghlemma AS BINARY) = CAST(:lemma AS BINARY)")
                .setParameter("lemma", lemma)
                .uniqueResult();
        return id != null ? ((Number) id).intValue() : null;
    }

    private static Integer createNewLemma(Session session, String lemma) {
        session.createNativeQuery(
                "INSERT INTO mgh_lemma (mghlemma, bearbeitungsstatusid) VALUES (:lemma, 0)")
                .setParameter("lemma", lemma)
                .executeUpdate();
        Object id = session.createNativeQuery("SELECT LAST_INSERT_ID()").uniqueResult();
        return id != null ? ((Number) id).intValue() : null;
    }

    private static Integer getExistingBelegLemmaLink(Session session, int belegId) {
        Object id = session.createNativeQuery(
                "SELECT id FROM einzelbeleg_hatmghlemma WHERE einzelbelegid = :belegId LIMIT 1")
                .setParameter("belegId", belegId)
                .uniqueResult();
        return id != null ? ((Number) id).intValue() : null;
    }

    private static boolean createNewBelegLemmaLink(Session session, int belegId, int lemmaId) {
        int res = session.createNativeQuery(
                "INSERT INTO einzelbeleg_hatmghlemma (einzelbelegid, mghlemmaid) VALUES (:belegId, :lemmaId)")
                .setParameter("belegId", belegId)
                .setParameter("lemmaId", lemmaId)
                .executeUpdate();
        return res > 0;
    }

    private static boolean updateBelegLemmaLink(Session session, int linkId, int lemmaId) {
        int res = session.createNativeQuery(
                "UPDATE einzelbeleg_hatmghlemma SET mghlemmaid = :lemmaId WHERE id = :linkId")
                .setParameter("lemmaId", lemmaId)
                .setParameter("linkId", linkId)
                .executeUpdate();
        return res > 0;
    }

    public static boolean setLemmaKorr(List<Integer> belegIdList, boolean korr) {
        if (belegIdList == null || belegIdList.isEmpty()) {
            return true;
        }
        Transaction tx = null;
        try (Session session = getSession()) {
            tx = session.beginTransaction();
            for (Integer belegId : belegIdList) {
                int updated = session.createNativeQuery(
                        "UPDATE einzelbeleg SET mghlemmakorrigiert = :korr WHERE id = :id")
                        .setParameter("korr", korr ? 1 : 0)
                        .setParameter("id", belegId)
                        .executeUpdate();
                if (updated != 1) {
                    throw new Exception("Update fehlgeschlagen für ID: " + belegId);
                }
            }
            tx.commit();
            return true;
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
            return false;
        }
    }
}
