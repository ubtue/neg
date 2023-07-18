package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.CriteriaUpdate;
import javax.persistence.criteria.Root;
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
        try (Session session = getSession()) {
            String SQL = "SELECT * FROM namenkommentar WHERE namenkommentar.ID in (SELECT n.ID FROM einzelbeleg e, quelle q, einzelbeleg_hatnamenkommentar h, namenkommentar n WHERE e.ID=h.einzelbelegID and n.ID=h.namenkommentarID and e.QuelleID=q.ID AND q.ZuVeroeffentlichen=1) order by namenkommentar.ID  ASC";
            NativeQuery query = session.createNativeQuery(SQL);
            query.addEntity(NamenKommentar.class);
            query.setMaxResults(1);
            return (NamenKommentar) query.getSingleResult();
        }
    }

     public static NamenKommentar getById(int id) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<NamenKommentar> criteria = builder.createQuery(NamenKommentar .class);
            Root namenkommentar = criteria.from(NamenKommentar .class);
            criteria.select(namenkommentar);
            criteria.where(builder.equal( namenkommentar.get(NamenKommentar_.ID), id));
            NamenKommentar res = session.createQuery(criteria).getSingleResult();
            return res;
        }
    }


    public static List<NamenKommentar> searchByFileName(String filename) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<NamenKommentar> criteria = builder.createQuery(NamenKommentar .class);
            Root namenkommentar = criteria.from(NamenKommentar .class);
            criteria.select(namenkommentar);
            criteria.where(builder.equal( namenkommentar.get(NamenKommentar_.DATEINAME), filename));
            List<NamenKommentar> res = session.createQuery(criteria).getResultList();
            return res;
        }
    }

    public static void saveOrUpdate(NamenKommentar namenkommentar) throws Exception {
        try (Session session = getSession()) {
            session.getTransaction().begin();
            session.saveOrUpdate(namenkommentar);
            session.getTransaction().commit();
        }
    }

    public static void setDateiname(int id, String dateiname) throws Exception {
        try (Session session = getSession()) {
            session.beginTransaction();

            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaUpdate<NamenKommentar> criteriaUpdate = builder.createCriteriaUpdate(NamenKommentar.class);
            Root<NamenKommentar> root = criteriaUpdate.from(NamenKommentar.class);

            criteriaUpdate.set(root.get(NamenKommentar_.DATEINAME), dateiname);
            criteriaUpdate.where(builder.equal(root.get(NamenKommentar_.ID), id));

            session.createQuery(criteriaUpdate).executeUpdate();

            session.getTransaction().commit();
        }
    }
}
