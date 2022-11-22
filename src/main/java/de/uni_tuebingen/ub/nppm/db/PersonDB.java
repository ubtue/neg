package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.IOException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.jsp.JspWriter;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

public class PersonDB extends AbstractBase {

    public static List getListPerson() throws Exception {
        return getList(Person.class);
    }

    public static List getListPersonAmtStandWeihe() throws Exception {
        return getList(PersonAmtStandWeihe_MM.class);
    }

    public static List getListPersonQuiet() throws Exception {
        return getList(PersonQuiet.class);
    }

    public static List getListPersonVariante() throws Exception {
        return getList(PersonVariante.class);
    }

     public static Person getFirstPublicPerson() throws Exception, Exception {

        Session session = getSession();
        String SQL = "SELECT * FROM person WHERE ID IN (SELECT PersonID FROM einzelbeleg_hatperson WHERE EinzelbelegID IN (SELECT einzelbeleg.id FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1))ORDER BY id ASC";

        NativeQuery query = session.createSQLQuery(SQL);
        query.addEntity(Person.class);
        query.setMaxResults(1);
        return (Person)query.getSingleResult();
    }
     
    public static boolean removeAmtStandWeiheFromPerson(int personHatAmtStandWeiheId, JspWriter out) {
        try {
            if (personHatAmtStandWeiheId > 0) {
                Session session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation to get the Ids for Person and AmtStandWeihe
                PersonAmtStandWeihe_MM rel = session.load(PersonAmtStandWeihe_MM.class, personHatAmtStandWeiheId);
                //Get Person
                Person person = rel.getPerson();
                //Get AmtStandWeihe
                SelektionAmtWeihe areal = rel.getAmtWeihe();
                //Remove AmtStandWeihe from Person
                person.getAmtWeihe().removeIf(e -> e.getId() == areal.getId());
                //Remove Person from AmtStandWeihe
                areal.getPersonen().removeIf(e -> e.getId() == person.getId());
                //Update both Entities
                session.update(person);
                session.update(areal);
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

    public static boolean removeArealFromPerson(int personHatArealId, JspWriter out) {
        try {
            if (personHatArealId > 0) {
                Session session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation to get the Ids for Person and AmtStandWeihe
                PersonAreal_MM rel = session.load(PersonAreal_MM.class, personHatArealId);
                //Get Person
                Person person = rel.getPerson();
                //Get SelektionAreal
                SelektionAreal areal = rel.getAreal();
                //Remove SelektionAreal from Person
                person.getAreal().removeIf(e -> e.getId() == areal.getId());
                //Remove Person from SelektionAreal
                areal.getPersonen().removeIf(e -> e.getId() == person.getId());
                //Update both Entities
                session.update(person);
                session.update(areal);
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

    public static boolean removeEthnieFromPerson(int personHatEthnieId, JspWriter out) {
        try {
            if (personHatEthnieId > 0) {
                Session session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation to get the Ids for Person and AmtStandWeihe
                PersonEthnie_MM rel = session.load(PersonEthnie_MM.class, personHatEthnieId);
                //Get Person
                Person person = rel.getPerson();
                //Get SelektionEthnie
                SelektionEthnie ethnie = rel.getEthnie();
                //Remove SelektionEthnie from Person
                person.getEthnie().removeIf(e -> e.getId() == ethnie.getId());
                //Remove Person from SelektionEthnie
                ethnie.getPersonen().removeIf(e -> e.getId() == person.getId());
                //Update both Entities
                session.update(person);
                session.update(ethnie);
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

    public static boolean removeVerwandtMitFromPerson(int personVerwandtMitId, JspWriter out) {
        try {
            if (personVerwandtMitId > 0) {
                Session session = getSession();
                Transaction transaction = session.getTransaction();
                transaction.begin();
                //Load the M to M Relation to get the Ids for Persons
                PersonVerwandtMit_MM rel = session.load(PersonVerwandtMit_MM.class, personVerwandtMitId);
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