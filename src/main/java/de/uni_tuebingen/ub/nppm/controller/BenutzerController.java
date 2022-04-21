package de.uni_tuebingen.ub.nppm.controller;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.model.BenutzerGruppe;

public class BenutzerController extends AbstractBase {

    public static List getList() throws Exception {
        Session session = getSession();
        List<Benutzer> list = session.createQuery("FROM Benutzer ORDER BY Nachname ASC, Vorname ASC", Benutzer.class).getResultList();
        return list;
    }

    public static List getListAktiv() throws Exception {
        Session session = getSession();
        List<Benutzer> list = session.createQuery("FROM Benutzer WHERE IstAktiv=1 ORDER BY Nachname ASC, Vorname ASC", Benutzer.class).getResultList();
        return list;
    }

    public static List getListInaktiv() throws Exception {
        Session session = getSession();
        List<Benutzer> list = session.createQuery("FROM Benutzer WHERE IstAktiv=0 ORDER BY Nachname ASC, Vorname ASC", Benutzer.class).getResultList();
        return list;
    }

    public static String getGruppeBezeichnung(int ID) throws Exception {
        Session session = getSession();
        BenutzerGruppe gruppe = session.createQuery("FROM BenutzerGruppe WHERE ID=" + Integer.toString(ID), BenutzerGruppe.class).getSingleResult();
        return gruppe.getBezeichnung();
    }
}
