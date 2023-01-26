package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.*;

public class BenutzerDB extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();

        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));
            
            return session.createQuery(criteria).getResultList();
        } finally {
            session.close();
        }
    }

    public static List getListAktiv() throws Exception {
        Session session = getSession();

        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.isTrue(benutzer.get(Benutzer_.IstAktiv)));
            criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));
            
            return session.createQuery(criteria).getResultList();
        } finally {
            session.close();
        }
    }

    public static List getListInaktiv() throws Exception {
        Session session = getSession();

        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.isFalse(benutzer.get(Benutzer_.IstAktiv)));
            criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));
            
            return session.createQuery(criteria).getResultList();
        } finally {
            session.close();
        }
    }

    public static Benutzer getById(int id) throws Exception {
        Session session = getSession();
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.equal(benutzer.get(Benutzer_.ID), id));
            Benutzer res = session.createQuery(criteria).getSingleResult();
            return res;
        } finally {
            session.close();
        }
    }

    public static Benutzer getByLogin(String login) throws Exception {
        Session session = getSession();
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.equal(benutzer.get(Benutzer_.Login), login));
            Benutzer res = session.createQuery(criteria).getSingleResult();
            return res;
        } finally {
            session.close();
        }
    }

    public static Benutzer getByMail(String mail) throws Exception {
        Session session = getSession();
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.equal(benutzer.get(Benutzer_.EMail), mail));
            Benutzer res = session.createQuery(criteria).getSingleResult();
            return res;
        } finally {
            session.close();
        }
    }

    public static boolean hasEmail(String email) throws Exception{
        Session session = getSession();

        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.equal(benutzer.get(Benutzer_.EMail), email));
            boolean inDatabase = !session.createQuery(criteria).getResultList().isEmpty();
            session.close();
            return inDatabase;
        } finally {
            session.close();
        }
    }

    public static boolean hasLogin(String login) throws Exception{
        Session session = getSession();

        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
            Root benutzer = criteria.from(Benutzer.class);
            criteria.select(benutzer);
            criteria.where(builder.equal(benutzer.get(Benutzer_.Login), login));
            boolean inDatabase = !session.createQuery(criteria).getResultList().isEmpty();
            
            return inDatabase;
        } finally {
            session.close();
        }
    }

    public static void saveOrUpdate(Benutzer b) throws Exception {
        Session session = getSession();
        try {
            session.getTransaction().begin();
            session.saveOrUpdate(b);
            session.getTransaction().commit();
        } finally {
            session.close();
        }
    }
}
