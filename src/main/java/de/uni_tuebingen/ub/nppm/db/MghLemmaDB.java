package de.uni_tuebingen.ub.nppm.db;


import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class MghLemmaDB extends AbstractBase {

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
}
