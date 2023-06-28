package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import de.uni_tuebingen.ub.nppm.model.DatenbankTexte;
import de.uni_tuebingen.ub.nppm.model.DatenbankTexte_;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;

public class DatenbankTexteDB extends AbstractBase {

    public static DatenbankTexte getText(String formular, String textfeld) throws Exception {
        Session session = getSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<DatenbankTexte> criteria = builder.createQuery(DatenbankTexte.class);
        Root<DatenbankTexte> titel = criteria.from(DatenbankTexte.class);

        criteria.select(titel);
        criteria.where(builder.and(
                builder.equal(titel.get(DatenbankTexte_.FORMULAR), formular),
                builder.equal(titel.get(DatenbankTexte_.TEXTFELD), textfeld)
        ));

        DatenbankTexte content = session.createQuery(criteria).getSingleResult();
        session.close();
        return content;
    }
}