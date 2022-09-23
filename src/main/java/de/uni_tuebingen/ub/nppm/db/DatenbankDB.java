package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.*;
import javax.persistence.criteria.*;

public class DatenbankDB extends AbstractBase {

    public static String getLabel(String language, String formular, String textfeld) throws Exception {
        Session session = getSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<DatenbankTexte> criteria = criteriaBuilder.createQuery(DatenbankTexte.class);
        Root<DatenbankTexte> root = criteria.from(DatenbankTexte.class);
        criteria.select(root).where(
                criteriaBuilder.and(
                        criteriaBuilder.equal(root.get("textfeld"), textfeld),
                        criteriaBuilder.equal(root.get("formular"), formular)
                )
        );
        Query query = session.createQuery(criteria);
        DatenbankTexte item = (DatenbankTexte) query.getSingleResult();
                if (item != null) {
            return item.getDe();
        }

        return null;
    }

    public static List getListFilter() throws Exception {
        return getList(DatenbankFilter.class);
    }

    public static List getListMapping() throws Exception {
        return getList(DatenbankMapping.class);
    }

    public static List getListSelektion() throws Exception {
        return getList(DatenbankSelektion.class);
    }

    public static List getListSprache() throws Exception {
        return getList(DatenbankSprache.class);
    }

    public static List getListTexte() throws Exception {
        return getList(DatenbankTexte.class);
    }
}