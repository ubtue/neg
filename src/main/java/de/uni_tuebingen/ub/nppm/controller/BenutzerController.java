package de.uni_tuebingen.ub.nppm.controller;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

public class BenutzerController extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
        Root benutzer = criteria.from(Benutzer.class);
        criteria.select(benutzer);
        criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));

        return session.createQuery(criteria).getResultList();
    }

    public static List getListAktiv() throws Exception {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
        Root benutzer = criteria.from(Benutzer.class);
        criteria.select(benutzer);
        criteria.where(builder.isTrue(benutzer.get(Benutzer_.IstAktiv)));
        criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));

        return session.createQuery(criteria).getResultList();
    }

    public static List getListInaktiv() throws Exception {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
        Root benutzer = criteria.from(Benutzer.class);
        criteria.select(benutzer);
        criteria.where(builder.isFalse(benutzer.get(Benutzer_.IstAktiv)));
        criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));

        return session.createQuery(criteria).getResultList();
    }
}
