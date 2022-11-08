package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

public class UrkundeDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Urkunde.class);
    }
    
    public static int determineUrkundeId(Integer quelleId) throws Exception{
        
        String sqlId = "SELECT ID FROM urkunde WHERE QuelleID ="+ quelleId + ";";
                
        Object urkundeId = DatenbankDB.getSingleResult(sqlId);
        //check if urkunde exist
        if(urkundeId != null)
            return (int)urkundeId;
        
        //if not, insert new urkunde
        Session session = getSession();
        String sqlInsertUrkunde = "INSERT into urkunde (QuelleID) values ('"+ quelleId + "')";
        session.getTransaction().begin();
        NativeQuery query = session.createSQLQuery(sqlInsertUrkunde);
        query.executeUpdate();
        session.getTransaction().commit();
        
        //return urkunde id
        return (int)DatenbankDB.getSingleResult(sqlId);        
    }
}
