package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.*;

public class EinzelbelegMGHLemmaDB extends AbstractBase {

    public static List<EinzelbelegMghLemma_MM> getByEinzelbelegId(int einzelbelegId) throws Exception {
        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<EinzelbelegMghLemma_MM> query = builder.createQuery(EinzelbelegMghLemma_MM.class);
            Root<EinzelbelegMghLemma_MM> root = query.from(EinzelbelegMghLemma_MM.class);

            // Join to fetch Einzelbeleg and filter by EinzelbelegID
            root.fetch("einzelbeleg", JoinType.INNER);
            query.select(root).where(builder.equal(root.get("einzelbeleg").get("id"), einzelbelegId));

            return session.createQuery(query).getResultList();
        }
    }

    public static void insertLemma(String einzelbelegId, String mghLemmaId) throws Exception {
        String sql = "INSERT INTO einzelbeleg_hatmghlemma(EinzelbelegID, MGHLemmaID) VALUES(" + einzelbelegId + ", " + mghLemmaId + ")";
        insertOrUpdate(sql);
    }
}
