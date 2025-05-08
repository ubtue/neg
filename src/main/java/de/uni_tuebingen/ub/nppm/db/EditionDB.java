package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.Session;

public class EditionDB extends AbstractBase {
    public static Edition getById(int id) throws Exception {
        return AbstractBase.getById(id, Edition.class);
    }

    public static List getList() throws Exception {
        return getList(Edition.class);
    }
}
