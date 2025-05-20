package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class LemmaDB extends AbstractBase {

    public static MghLemma getById(int id) throws Exception {
        return AbstractBase.getById(id, MghLemma.class);
    }

    public static List getList() throws Exception {
        return getList(MghLemma.class);
    }

    public static List getListBearbeiter() throws Exception {
        return getList(MghLemmaBearbeiter.class);
    }

    public static List getListKorrektor() throws Exception {
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
                    + "        AND mgh_lemma.MGHLemma NOT LIKE '%[???]%' "
                    + "    ) THEN :id "
                    + "    ELSE ( "
                    + "      SELECT MIN(mgh_lemma.ID) "
                    + "      FROM mgh_lemma "
                    + "      JOIN einzelbeleg_hatmghlemma h ON mgh_lemma.ID = h.MGHLemmaID "
                    + "      JOIN einzelbeleg e ON e.ID = h.EinzelbelegID "
                    + "      JOIN quelle q ON e.QuelleID = q.ID "
                    + "      WHERE q.ZuVeroeffentlichen = 1 AND mgh_lemma.ID > :id "
                    + "        AND mgh_lemma.MGHLemma NOT LIKE '%[???]%' "
                    + "    ) "
                    + "  END AS resultId "
                    + "FROM ( "
                    + "  SELECT MIN(mgh_lemma.ID) AS minId, MAX(mgh_lemma.ID) AS maxId "
                    + "  FROM mgh_lemma "
                    + "  JOIN einzelbeleg_hatmghlemma h ON mgh_lemma.ID = h.MGHLemmaID "
                    + "  JOIN einzelbeleg e ON e.ID = h.EinzelbelegID "
                    + "  JOIN quelle q ON e.QuelleID = q.ID "
                    + "  WHERE q.ZuVeroeffentlichen = 1 "
                    + "        AND mgh_lemma.MGHLemma NOT LIKE '%[???]%' "
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
        return getStringListNative("SELECT DISTINCT SUBSTRING_INDEX(MGHLemma, '~', 1) AS Erstglied  FROM neg.mgh_lemma WHERE MGHLemma LIKE '%~%' ORDER BY Erstglied ASC");
    }

    public static List<String> getListZweitglied() throws Exception {
        return getStringListNative("SELECT DISTINCT SUBSTRING_INDEX(MGHLemma, '~', -1) AS Zweitglied  FROM neg.mgh_lemma WHERE MGHLemma LIKE '%~%' ORDER BY Zweitglied ASC");
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
}
