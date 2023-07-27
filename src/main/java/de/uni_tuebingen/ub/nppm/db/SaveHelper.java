package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.DatenbankMapping;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;

public class SaveHelper extends AbstractBase {
    public static int getMaxId(String form) throws Exception {
        return (int)DatenbankDB.getSingleResult("SELECT max(ID) ID FROM "+form);
    }

    public static boolean existForm(String form, int id) throws Exception {
        return DatenbankDB.getSingleResult("SELECT * FROM "+form+" WHERE ID="+id) != null;
    }

    public static void insertMetaData(String form, int id, int benutzerID, int gruppenID) throws Exception {
        String sql = "INSERT INTO "+form+" (ID, Erstellt, ErstelltVon, GehoertGruppe)"
                    +" VALUES("+id+", NOW(), "+benutzerID+", "+gruppenID+");";
        insertOrUpdate(sql);
    }

    public static void updateMetaData(String form, int id, int benutzerID) throws Exception {
        String sql = "UPDATE "+form+" SET LetzteAenderung = NOW(), LetzteAenderungVon=\""+benutzerID+"\" WHERE ID="+id+";";
        insertOrUpdate(sql);
    }

   public static List<DatenbankMapping> getMapping(String formular) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<DatenbankMapping> criteria = criteriaBuilder.createQuery(DatenbankMapping.class);
            Root<DatenbankMapping> root = criteria.from(DatenbankMapping.class);
            criteria.select(root).where(
                    criteriaBuilder.and(
                            criteriaBuilder.equal(root.get("formular"), formular)
                    )
            );
            org.hibernate.query.Query query = session.createQuery(criteria);
            List<DatenbankMapping> rows = query.getResultList();
            return rows;
        }
    }

    public static String getSingleField(String zielAttribut, String zieltabelle, int id) throws Exception {
        String sql = "SELECT " + zielAttribut + " FROM " + zieltabelle + " WHERE ID='" + id + "';";
        try {
            Object res = DatenbankDB.getSingleResult(sql);
            if (res != null) {
                return res.toString();
            }
            return null;
        } catch (Exception exception) {
            throw new Exception(exception.getLocalizedMessage()+"\nSQL: "+sql);
        }
    }

    public static void insertOrUpdateSql(String sql) throws Exception {
        try {
            insertOrUpdate(sql);
        } catch (Exception exception) {
            throw new Exception(exception.getLocalizedMessage()+"\nSQL: "+sql);
        }
    }
}
