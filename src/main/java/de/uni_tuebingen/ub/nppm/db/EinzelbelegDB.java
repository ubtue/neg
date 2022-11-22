package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.jsp.JspWriter;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class EinzelbelegDB extends AbstractBase {

    public static Einzelbeleg getById(int id) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Einzelbeleg> criteria = builder.createQuery(Einzelbeleg.class);
        Root einzelbeleg = criteria.from(Einzelbeleg.class);
        criteria.select(einzelbeleg);
        criteria.where(builder.equal(einzelbeleg.get(Einzelbeleg_.ID), id));
        Einzelbeleg res =  session.createQuery(criteria).getSingleResult();
        return res;
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
    
    public static boolean removeMghLemmaFromEinzelbeleg(int einzelbelegHatmghlemmaId, JspWriter out){
        Session session;
        try {
            if(einzelbelegHatmghlemmaId > 0){
                session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation to get the Ids for Einzelbeleg and MGHLemma
                EinzelbelegMghLemma_MM rel = session.load(EinzelbelegMghLemma_MM.class, einzelbelegHatmghlemmaId);
                //Get Einzelbeleg
                Einzelbeleg einzelbeleg = rel.getEinzelbeleg();                   
                //Get Mgh Lemma
                MghLemma mgh = rel.getMghLemma();
                //Remove Mgh Lemma from Einzelbeleg
                einzelbeleg.getMghLemma().removeIf(e -> e.getId() == mgh.getId());
                //Remove Einzelbeleg from Mgh Lemma
                mgh.getEinzelbeleg().removeIf(e -> e.getId() == einzelbeleg.getId());
                //Update both Entities
                session.update(einzelbeleg);
                session.update(mgh);                
                //Commit
                transaction.commit();                
                return true;
            }
        } catch (Exception ex) {
            try {
                out.print(ex.getLocalizedMessage());
            } catch (IOException ex1) {

            }
        }
        return false;
    }
    
    

    public static Einzelbeleg getFirstPublicEinzelbeleg() throws Exception {
        Session session = getSession();
        String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
        Query query = session.createQuery(HQL).setMaxResults(1);
        Einzelbeleg einzelbeleg = (Einzelbeleg)query.getSingleResult();
        return einzelbeleg;
    }

    public static boolean removeNamenKommentarFromEinzelbeleg(int einzelbelegHatNamenkommentarId, JspWriter out) {
        Session session;
        try {
            if(einzelbelegHatNamenkommentarId > 0){
                session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation to get the Ids for Einzelbeleg and Namenkommentar
                EinzelbelegNamenkommentar_MM rel = session.load(EinzelbelegNamenkommentar_MM.class, einzelbelegHatNamenkommentarId);
                //Get Einzelbeleg
                Einzelbeleg einzelbeleg = rel.getEinzelbeleg();                   
                //Get NamenKommentar
                NamenKommentar namenkommentar = rel.getNamenKommentar();
                //Remove NamenKommentar from Einzelbeleg
                einzelbeleg.getNamenKommentar().removeIf(e -> e.getId() == namenkommentar.getId());
                //Remove Einzelbeleg from Mgh Lemma
                namenkommentar.getEinzelbeleg().removeIf(e -> e.getId() == einzelbeleg.getId());
                //Update both Entities
                session.update(einzelbeleg);
                session.update(namenkommentar);                
                //Commit
                transaction.commit();                
                return true;
            }
        } catch (Exception ex) {
            try {
                out.print(ex.getLocalizedMessage());
            } catch (IOException ex1) {

            }
        }
        return false;
    }

    public static boolean removePersonFromEinzelbeleg(int einzelbelegHatPersonId, JspWriter out) {
        try {
            if (einzelbelegHatPersonId > 0) {
                Session session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation
                EinzelbelegHatPerson_MM rel = session.load(EinzelbelegHatPerson_MM.class, einzelbelegHatPersonId);
                //Remove Record
                session.delete(rel);
                //Commit
                transaction.commit();
                return true;
            }
        } catch (Exception ex) {
            try {
                //print error message
                out.print(ex.getLocalizedMessage());
            } catch (IOException ex1) {

            }
        }
        return false;
    }
}