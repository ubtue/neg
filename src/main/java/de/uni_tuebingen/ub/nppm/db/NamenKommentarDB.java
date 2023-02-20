package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class NamenKommentarDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(NamenKommentar.class);
    }

    public static List getListBearbeiter() throws Exception {
        return getList(NamenKommentarBearbeiter.class);
    }

    public static List getListKorrektor() throws Exception {
        return getList(NamenKommentarKorrektor.class);
    }

    public static NamenKommentar getFirstPublicNamenlemma() throws Exception {

        Session session = getSession();
        String SQL = "SELECT * FROM namenkommentar WHERE namenkommentar.ID in (SELECT n.ID FROM einzelbeleg e, quelle q, einzelbeleg_hatnamenkommentar h, namenkommentar n WHERE e.ID=h.einzelbelegID and n.ID=h.namenkommentarID and e.QuelleID=q.ID AND q.ZuVeroeffentlichen=1) order by namenkommentar.ID  ASC";
        NativeQuery query = session.createSQLQuery(SQL);
        query.addEntity(NamenKommentar.class);
        query.setMaxResults(1);
        NamenKommentar result = (NamenKommentar)query.getSingleResult();
        session.close();
        return result;
    }
}