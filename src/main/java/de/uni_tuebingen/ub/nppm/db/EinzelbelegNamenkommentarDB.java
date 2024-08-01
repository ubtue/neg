package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.*;


public class EinzelbelegNamenkommentarDB extends AbstractBase {

   public static List<EinzelbelegNamenkommentar_MM> getByEinzelbelegId(int einzelbelegId) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<EinzelbelegNamenkommentar_MM> query = builder.createQuery(EinzelbelegNamenkommentar_MM.class);
            Root<EinzelbelegNamenkommentar_MM> root = query.from(EinzelbelegNamenkommentar_MM.class);

            // Join to fetch Einzelbeleg and filter by EinzelbelegID
            root.fetch("einzelbeleg", JoinType.INNER);
            query.select(root).where(builder.equal(root.get("einzelbeleg").get("id"), einzelbelegId));

            return session.createQuery(query).getResultList();
        }
    }

    public static void insertNamenkommentar(String einzelbelegId, String namenkommentarId) throws Exception {
        String sql = "INSERT INTO einzelbeleg_hatnamenkommentar(EinzelbelegID, NamenkommentarID) VALUES(" + einzelbelegId + ", " + namenkommentarId + ")";
        insertOrUpdate(sql);
    }
}