package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
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

    public static Person getFirstPublicPerson() throws Exception {
        try{
            Session session = getSession();
        //String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
       // String HQL = "FROM Person WHERE ID IN (SELECT PersonID FROM einzelbeleg_hatperson WHERE EinzelbelegID IN (SELECT einzelbeleg.id FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1)) ORDER BY id ASC";
     //   String HQL = "From Person Where ID = 264";
          String HQL = "From Person Where ID IN (SELECT PersonID FROM einzelbeleg_hatperson where PersonID = 21506)";

         String SQL = "select * from person where ID IN (SELECT PersonID FROM einzelbeleg_hatperson where EinzelbelegID IN (SELECT einzelbeleg.id FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1)ORDER BY id ASC";
         SQLQuery query = session.createSQLQuery(SQL);
         query.addEntity(Person.class);
         List<Person> persons = query.list();
         for(Person o : persons)
         {
             return o;
         }
       // Query query = session.createQuery(HQL).setMaxResults(1);
     //   Person person = (Person)query.getSingleResult();
         return null;
        }
        catch(Exception e)
        {

        }
        return null;

    }




    /*

     public static Einzelbeleg getFirstPublicPerson() throws Exception {
        Session session = getSession();
        //String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
        String HQL = "FROM Person WHERE id IN (SELECT PersonID FROM einzelbeleg_hatperson WHERE EinzelbelegID IN (SELECT einzelbeleg.ID FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1)) ORDER BY id ASC";
        Query query = session.createQuery(HQL).setMaxResults(1);
        Einzelbeleg einzelbeleg = (Einzelbeleg)query.getSingleResult();
        return einzelbeleg;
    }







     public static Einzelbeleg getFirstPublicEinzelbeleg() throws Exception {
        Session session = getSession();
        String HQL = "FROM Einzelbeleg WHERE QuelleID IN (SELECT id FROM Quelle WHERE ZuVeroeffentlichen=1) ORDER BY id ASC";
        Query query = session.createQuery(HQL).setMaxResults(1);
        Einzelbeleg einzelbeleg = (Einzelbeleg)query.getSingleResult();
        return einzelbeleg;
    }
*/
}