package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.*;
import java.util.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.json.*;

/**
 * Class for functions which can be applied to all Selektion...- tables
 * in a similar way
 */
public class SelektionDB extends AbstractBase {

    static protected Map<String,String> gastToNonGast = Map.ofEntries(
        Map.entry("gastselektion_amtweihe_einzelbeleg", "selektion_amtweihe"),
        Map.entry("gastselektion_amtweihe_person", "selektion_amtweihe"),
        Map.entry("gastselektion_quellengattung", "selektion_quellengattung")
    );

    static public List<Selektion> getList(String selektion) throws Exception {
        return getList(getEntityClassByTableName(selektion));
    }

    static public List<SelektionHierarchy> getListHierarchy(String selektion) throws Exception {
        Class c = getEntityClassByTableName(selektion);

        try (Session session = getSession()) {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery query = builder.createQuery(c);
            Root root = query.from(c);
            query.select(root);
            // Order is important for sorting before display rendering the hierarchy
            query.orderBy(builder.asc(root.get(SelektionBezeichnung_.BEZEICHNUNG)));
            return session.createQuery(query).setCacheable(true).getResultList();
        }
    }

    static public String getListHierarchyJson(String selektion) throws Exception {
        JSONArray array = new JSONArray();
        List<SelektionHierarchy> list = getListHierarchy(selektion);
        for (SelektionHierarchy entry : list) {
            array.put(entry.toJSONObject());
        }
        return array.toString();
    }

    static public String getNonGastTable(String selektion) {
        return gastToNonGast.get(selektion);
    }

    static public boolean isHierarchy(String selektion) {
        try {
            Class c = getEntityClassByTableName(selektion);
            return SelektionHierarchy.class.isAssignableFrom(c);
        } catch (Exception e) {
            // right now we don't have all gast... views registered as entities yet,
            // so we simply return false in this case.
            return false;
        }
    }

    static public void updateParentId(String selektion, int id, Integer parentId) throws Exception {
        String intVal = "NULL";
        if (parentId != null)
            intVal = parentId.toString();
        String sql = "UPDATE " + selektion + " SET parentId=" + intVal + " WHERE ID=" + id;
        insertOrUpdate(sql);
    }
}
