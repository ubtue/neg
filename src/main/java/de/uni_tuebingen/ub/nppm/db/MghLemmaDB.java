package de.uni_tuebingen.ub.nppm.db;


import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class MghLemmaDB extends AbstractBase {

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
    
    public static List<MghLemma> getByName(String name) throws Exception{
        String sql = "SELECT * FROM mgh_lemma WHERE MGHLemma" + " LIKE '%" + name + "%' ";
        sql += " ORDER BY MGHLemma";

        try ( Session session = getSession()) {
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
}
